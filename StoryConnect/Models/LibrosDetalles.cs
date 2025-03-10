using System.ComponentModel.DataAnnotations;

namespace StoryConnect.Models
{
    public class LibrosDetalles
    {
        public Libros Libro { get; set; }
        public List<Etiquetas> Etiquetas { get; set; }
    }
}
