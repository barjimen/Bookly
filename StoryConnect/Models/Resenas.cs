using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StoryConnect.Models
{
    [Table("RESENAS")]
    public class Resenas
    {
        [Key]

        [Column("ID")]
        public int Id { get; set; }
        [Column("USUARIO_ID")]
        public int idUsuario { get; set; }
        [Column("LIBRO_ID")]
        public int idPedido { get; set; }
        [Column("CALIFICACION")]
        public int calificacion { get; set; }
        [Column("TEXTO")]
        public string resena {  get; set; }
        [Column("FECHA_PUBLICACION")]
        public string fecha { get; set; }
    }
}
