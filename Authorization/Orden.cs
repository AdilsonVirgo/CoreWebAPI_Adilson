using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CoreWebAPI_Adilson.Authorization
{
    public class Orden
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        [Required]
        public string Estado { get; set; }
        //created,canceled,confirmed

        [Required]
        public DateTime Fecha { get; set; }

        
        public virtual Producto Producto { get; set; }
        public virtual ApplicationUser Usuario { get; set; }
    }
}
