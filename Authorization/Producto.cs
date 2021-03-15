using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CoreWebAPI_Adilson.Authorization
{
    [Table("producto")]
    public class Producto
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        [Required]
        public string Nombre { get; set; }

        [Required]
        [Column(TypeName = "varchar(100)")]
        public string Descripcion { get; set; }

        [Required]
        public int Cantidad { get; set; }

        [Required]
        public string Slug { get; set; }

        [Required]
        [Column(TypeName = "decimal(5, 2)")]
        public decimal Precio { get; set; }
    }
}
