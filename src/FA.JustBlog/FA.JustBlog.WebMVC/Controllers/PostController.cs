using FA.JustBlog.Services;
using System;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace FA.JustBlog.WebMVC.Controllers
{
    public class PostController : Controller
    {
        private readonly IPostServices _postServices;

        public PostController(IPostServices postServices)
        {
            _postServices = postServices;
        }

        [HttpGet]
        public async Task<ActionResult> Index()
        {
            var posts = await _postServices.GetAllAsync();
            return View(posts);
        }

        public async Task<ActionResult> Detail(Guid id)
        {
            var post = await _postServices.GetByIdAsync(id);
            return View(post);
        }

        public async Task<ActionResult> Details(int year, int month, string urlSlug)
        {
            var post = await _postServices.FindPostAsync(year, month, urlSlug);
            if (post == null)
            {
                return HttpNotFound();
            }
            return View("Detail", post);
        }

        public ActionResult LastestPost()
        {
            var posts = _postServices.GetLatestPost(3);
            return PartialView("_LastestPost", posts);
        }

        public ActionResult MostViewedPost()
        {
            var posts = _postServices.GetMostViewedPost(5);
            return PartialView("_MostViewedPost", posts);
        }

        public async Task<ActionResult> GetPostByCategory(string category)
        {
            var posts = await _postServices.GetPostsByCategoryAsync(category);
            return View(posts);
        }

        public async Task<ActionResult> GetPostByTag(string tag)
        {
            var posts = await _postServices.GetPostsByTagAsync(tag);
            return View(posts);
        }
    }
}