using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace CoreWebAPI_Adilson.Authorization
{
    public class ApplicationUser : IdentityUser
    {
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
    }
}

