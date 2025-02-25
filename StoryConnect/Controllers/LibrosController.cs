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
            return View(libro);
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




    }
}
