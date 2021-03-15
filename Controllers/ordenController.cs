using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CoreWebAPI_Adilson.Authorization;
using Microsoft.AspNetCore.Authorization;

namespace CoreWebAPI_Adilson.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    [ApiController]
    public class ordenController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ordenController(ApplicationDbContext context)
        {
            _context = context;
        }



        /// <summary>
        /// Muestra un listado de ordenes
        /// </summary>
        /// <remarks>       
        /// 
        /// Ejemplo:
        ///
        ///     GET: api/orden
        ///
        /// </remarks>
        /// <returns>Listado de Ordenes</returns>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Orden>>> GetOrden()
        {
            return await _context.Orden.ToListAsync();
        }


        /// <summary>
        /// Muestra una Orden especifica .
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Ejemplo:
        ///
        ///     GET: api/orden/5
        ///     {
        ///     "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns>Orden</returns>
        /// <response code="400">NotFound si no se encuentra la orden</response> 
        [HttpGet("{id}")]
        public async Task<ActionResult<Orden>> GetOrden(int id)
        {
            var orden = await _context.Orden.FindAsync(id);

            if (orden == null)
            {
                return NotFound();
            }

            return orden;
        }

        /// <summary>
        /// Editar una orden.
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Solo para Rol Administrador,Ejemplo:
        ///
        ///     PUT: api/orden/5
        ///     {
        ///     "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns>Producto</returns>
        /// <response code="400">NotFound si no se encuentra la orden</response> 
        [Authorize(Roles = "Administrador")]
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrden(int id, Orden orden)
        {
            if (id != orden.id)
            {
                return BadRequest();
            }

            _context.Entry(orden).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrdenExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        /// <summary>
        /// Borrar una orden.
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Solo para Rol Administrador,Ejemplo:
        ///
        ///     DELETE: api/orden/5
        ///     {
        ///     "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns code="200">Borrado exitoso</returns>
        /// <returns>No Content si no puede eliminar</returns>
        /// <response code="400">NotFound si no se encuentra la orden</response> 
        [Authorize(Roles = "Administrador")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrden(int id)
        {
            var orden = await _context.Orden.FindAsync(id);
            if (orden == null)
            {
                return NotFound();
            }
            if (orden.Estado == "confirmada")
            {
                return NoContent();
            }
            else
            {
                _context.Orden.Remove(orden);
                await _context.SaveChangesAsync();
                return Ok(new Response { Status = "Success", Message = "Deleted successfully!" });
            }




        }

        private bool OrdenExists(int id)
        {
            return _context.Orden.Any(e => e.id == id);
        }
    }
}
