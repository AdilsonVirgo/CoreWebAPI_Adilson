using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using CoreWebAPI_Adilson.Authorization;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;

namespace CoreWebAPI_Adilson.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    [ApiController]
    public class tiendaController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public tiendaController(ApplicationDbContext context)
        {
            _context = context;
        }




        /// <summary>
        /// Comprar un Producto especifico .
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Authorizado como Cliente,
        /// Ejemplo:
        ///
        ///     GET api/tienda/1
        ///     {
        ///        "id": 1
        ///     }
        ///
        /// </remarks>
        /// <returns>NoContent</returns>
        /// <response code="NotFound">Si es producto no se encuentra devuelve Not Found</response>    
        [Authorize(Roles = "Cliente")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Producto>> ComprarProducto(int id)
        {
            var header = Request.Headers["Authorization"];
            string completeheader = header.ToString();
            string username = ProcessorBearerToken(completeheader);
            ApplicationUser usuarioRequest = _context.Users.Where<ApplicationUser>(x => x.UserName == username).First();

            var producto = await _context.Producto.FindAsync(id);
            if (producto == null)
            {
                return NotFound();
            }
            if (producto.Cantidad - 1 > 0)
            {
                producto.Cantidad--;
                _context.Entry(producto).State = EntityState.Modified;

                Orden orden = new Orden()
                {
                    Estado = "created",
                    Fecha = DateTime.Now,
                    Producto = producto,
                    Usuario = usuarioRequest
                };
                _context.Orden.Add(orden);

                try
                {
                    await _context.SaveChangesAsync();
                    return Ok(new Response { Status = "Success", Message = "Orden creada!" });
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ProductoExists(producto.id) || !OrdenExists(orden.id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
            }
            return NoContent();
        }

        private string ProcessorBearerToken(string completeheader)
        {
            string chunkWithCredential = completeheader.Substring("Bearer ".Length).Trim();
            var stream = chunkWithCredential;
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(stream);
            var tokenS = jsonToken as JwtSecurityToken;
            string nameValue = tokenS.Claims.First(claim => claim.Type == ClaimTypes.Name).Value;
            string roleValue = tokenS.Claims.First(claim => claim.Type == ClaimTypes.Role).Value;
            return nameValue;
        }

        private bool ProductoExists(int id)
        {
            return _context.Producto.Any(e => e.id == id);
        }
        private bool OrdenExists(int id)
        {
            return _context.Orden.Any(e => e.id == id);
        }

    }
}
