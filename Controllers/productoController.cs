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
    public class productoController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public productoController(ApplicationDbContext context)
        {
            _context = context;
        }


        /// <summary>
        /// Lista todos los productos
        /// </summary>
        /// <remarks>       
        /// 
        /// Ejemplo:
        ///
        ///     GET: api/producto
        ///
        /// </remarks>
        /// <returns>Listado de Producto</returns>
        /// <response code="200"></response> 
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Producto>>> GetProducto()
        {
            var header = Request.Headers["Authorization"];
            return await _context.Producto.ToListAsync();
        }



        /// <summary>
        /// Muestra un producto especifico .
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Ejemplo:
        ///
        ///     GET: api/producto/5
        ///     {
        ///     "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns>Producto</returns>
        /// <response code="400">NotFound si no se encuentra el producto</response>  
        [HttpGet("{id}")]
        public async Task<ActionResult<Producto>> GetProducto(int id)
        {
            var producto = await _context.Producto.FindAsync(id);

            if (producto == null)
            {
                return NotFound();
            }

            return producto;
        }


        /// <summary>
        /// Modifica un producto especifico .
        /// </summary>
        /// <param name="id"></param>
        /// <param name="producto"></param>
        /// <remarks>       
        /// 
        /// Authorizado como Administrador,
        /// Ejemplo:
        ///
        ///     PUT: api/producto/5
        ///     {
        ///     "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns>CreatedAtAction</returns>
        /// <response code="200"></response> 
        [Authorize(Roles = "Administrador")]
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProducto(int id, Producto producto)
        {
            if (id != producto.id)
            {
                return BadRequest();
            }

            _context.Entry(producto).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
                return Ok(new Response { Status = "Success", Message = "Orden creada!" });
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            //return NoContent();
        }


        /// <summary>
        /// Crea un producto especifico .
        /// </summary>
        /// <param name="producto"></param>
        /// <remarks>       
        /// 
        /// Authorizado como Administrador,
        /// Ejemplo:
        ///
        ///     POST: api/producto
        ///
        /// </remarks>
        /// <returns>CreatedAtAction</returns>
        /// <response code="200"></response> 
        [Authorize(Roles = "Administrador")]
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Producto>> PostProducto(Producto producto)
        {
            _context.Producto.Add(producto);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProducto", new { id = producto.id }, producto);
        }




        /// <summary>
        /// Borra un producto especifico .
        /// </summary>
        /// <param name="id"></param>
        /// <remarks>       
        /// 
        /// Authorizado como Cliente,
        /// Ejemplo:
        ///
        ///     DELETE: api/producto/5
        ///     {
        ///        "id": 5
        ///     }
        ///
        /// </remarks>
        /// <returns>NoContent</returns>
        /// <response code="NotFound">Si es producto no se encuentra devuelve Not Found</response>  
        [Authorize(Roles = "Administrador")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProducto(int id)
        {
            var producto = await _context.Producto.FindAsync(id);
            if (producto == null)
            {
                return NotFound();
            }

            _context.Producto.Remove(producto);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductoExists(int id)
        {
            return _context.Producto.Any(e => e.id == id);
        }

    }
}
