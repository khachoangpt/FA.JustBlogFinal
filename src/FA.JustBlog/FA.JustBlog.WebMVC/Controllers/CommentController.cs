using FA.JustBlog.Services;
using System;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace FA.JustBlog.WebMVC.Controllers
{
    public class CommentController : Controller
    {
        private readonly ICommentServices _commentServices;
        private readonly IPostServices _postServices;

        public CommentController(CommentServices commentServices, PostServices postServices)
        {
            _commentServices = commentServices;
            _postServices = postServices;
        }

        // GET: Comment
        public ActionResult Index(Guid id)
        {
            var comments = _commentServices.GetCommentsForPost(id);
            return PartialView("_ShowComments", comments);
        }
    }
}