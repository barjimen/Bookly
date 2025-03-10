using System.Data.Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StoryConnect.Models;
using System.Security.Cryptography;
using StoryConnect.Context;
using StoryConnect.Repositories;

namespace StoryConnect.Controllers
{
    public class UsuariosController : Controller
    {
        private IRepositoryLibros repo;
        public UsuariosController(IRepositoryLibros repo)
        {
            this.repo = repo;
        }
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Register(string nombre, string email, string password)
        {
            await this.repo.Register(nombre, email, password);
            ViewData["Mensaje"] = "Usuario registrado correctamente.";
            return RedirectToAction("Index", "Home");
        }

        public IActionResult Login()
        {
            return View();
        }


        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {
            var usuario = await this.repo.Login(email, password);
            if (usuario != null)
            {
                HttpContext.Session.SetInt32("id", usuario.Id);
                HttpContext.Session.SetString("nombre", usuario.Nombre);
                HttpContext.Session.SetString("email", usuario.email);
                HttpContext.Session.SetString("tipo_usuario", usuario.TipoUsuario);
                HttpContext.Session.SetString("imagen_perfil", usuario.ImagenPerfil);

                return RedirectToAction("Home", "Libros");
            }
            else
            {
                ViewData["MENSAJE"] = "Usuario o contraseña incorrectos.";
                return View();
            }
        }


        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }


        public IActionResult Index()
        {
            return View();
        }

        public async Task<IActionResult> Perfil()
        {
            int idUser = (int)HttpContext.Session.GetInt32("id");
            var usuario = await this.repo.GetUsuario(idUser);
            var CountLibros = await this.repo.ObtenerCountListas(idUser);
            var librosPredefinidos = await this.repo.LibrosEnPredefinidos(idUser);
            var objetivos = await this.repo.ObjetivosUsuarios(idUser);
            var homeUsuario = new HomeUsuario
            {
                Usuarios = usuario,
                CountLibrosPred = CountLibros,
                LibrosListasPred = librosPredefinidos,
                ObjetivosUsuarios = objetivos
            };

            return View(homeUsuario);
        }

        public async Task<IActionResult> MisLibros()
        {
            int idUser = (int)HttpContext.Session.GetInt32("id");
            var CountLibros = await this.repo.ObtenerCountListas(idUser);


            var MisLibros = new MisLibros
            {
                IdUsuario = idUser,
                CountLibrosPred = CountLibros
            };

            return View(MisLibros);
        }

        public async Task<IActionResult> FiltrarMisLibros(int idUsuario, int idLista)
        {
            if (idLista == 0)
            {
                var libros = await this.repo.LibrosEnPredefinidos(idUsuario);
                return PartialView("_LibrosPartial", libros);
            }
            else
            {
                var libros = await this.repo.FindLibrosEnPredefinidos(idUsuario, idLista);
                return PartialView("_LibrosPartial", libros);
            }
        }
    }
}
