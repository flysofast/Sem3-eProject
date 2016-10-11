using DemoDijkstra;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class TestAjaxController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Get shortes possible path for the route between 2 cities
        /// </summary>
        /// <param name="OriginalCityID"></param>
        /// <param name="DestinationCityID"></param>
        /// <returns></returns>
        public JsonResult GetPossibleRouteAPI(string OriginalCityID, string DestinationCityID)
        {
            try
            {
                Dijkstra d = new Dijkstra(OriginalCityID, DestinationCityID);
                var path = d.GetShortestPath();
                if (path.Count > 0)
                {
                    var result = new List<CityJson>();
                    for(int i = 0; i < path.Count; i++)
                    {
                        var item = new CityJson();
                        item.CityID = path[i].CityID;
                        item.CityName = path[i].CityName;
                        result.Add(item);
                    }
                    return Json(result, JsonRequestBehavior.AllowGet);

                }
                else
                {
                    return Json(0, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;

            }

        }

        public class CityJson
        {
            [Display(Name = "CityID")]
            public string CityID { set; get; }

            [Display(Name = "CityName")]
            public string CityName { set; get; }


        }


    }
}
