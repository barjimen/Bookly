using Microsoft.AspNetCore.Mvc;
using StoryConnect.Models;
using StoryConnect.Repositories;

namespace StoryConnect.Controllers
{
    public class LibrosController : Controller
    {
        private IRepositoryLibros repo;
        public LibrosController(IRepositoryLibros repo)
        {
            this.repo = repo;
        }
        public async Task<IActionResult> Index()
        {
            List<Libros> libro = 
                await this.repo.GetLibrosAsync();
            return View(libro);
        }

        public async Task<IActionResult> Detalles(int id)
        {
            Libros libro =
                await this.repo.FindLibros(id);
            var etiquetas = await this.repo.ObtenerEtiquetasLibro(id);
            var detallesLibro = new LibrosDetalles
            {
                Libro = libro,
                Etiquetas = etiquetas
            };
            return View(detallesLibro);
        }
        [HttpGet]
        public async Task<JsonResult> BuscarLibros(string query)
        {
            if (string.IsNullOrEmpty(query))
            {
                return Json(new { results = new List<object>() });
            }

            var libros = await this.repo.BuscarLibrosAsync(query);

            var resultado = libros.Select(l => new
            {
                id = l.Id,
                titulo = l.Titulo,
                autor = l.NombreAutor != null ? l.NombreAutor : "Autor desconocido"
            }).ToList();

            return Json(new { results = resultado });
        }

        public async Task<IActionResult> Home()
        {
            int? idUsuario = HttpContext.Session.GetInt32("id");

            List<LibrosLeyendo> libros = await this.repo.LibrosLeyendo(idUsuario.Value);

            // Pasar los libros a la vista
            return View(libros);
        }

        [HttpPost]
        public async Task<IActionResult> MoverLibrosEntreListas(int idlibro, int origen, int destino)
        {
            int idusuario = (int)HttpContext.Session.GetInt32("id");
            Console.WriteLine(idusuario.ToString(), idlibro, origen, destino);
            await this.repo.MoverLibrosLista(idusuario, idlibro, origen, destino);
            return RedirectToAction("Home");
        }


        
    }
}
