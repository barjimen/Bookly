using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StoryConnect.Models
{
    [Table("usuarios")]
    public class Usuarios
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }
        [Column("nombre")]
        public string Nombre { get; set; }
        [Column("email")]
        public string email { get; set; }
        [Column("password")]
        public byte[] Password { get; set; }
        [Column("imagen_perfil")]
        public string ImagenPerfil { get; set; }
        [Column("fecha_registro")]
        public DateTime FechaRegistro { get; set; } = DateTime.Now;
        [Column("tipo_usuario")]
        public string TipoUsuario { get; set; } = "lector";
    }
}
