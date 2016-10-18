using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

public class Constants
{
    public static string SessionUserIDKey = "UserID";
    public static string SessionIsLoggedInKey = "isLogged";
}

public class TicketStatus
{
    public static int Blocked = 0;
    public static int Confirmed = 1;
    public static int Cancelled = 2;
}

public class ClassNames
{
    public static string Any = "Any";
    public static string FirstClass = "First class";
    public static string BusinessClass = "Business class";
    public static string ClubClass = "Club class";
    public static string NonSmokingClass = "Non-smoking class";
    public static string SmokingClass = "Smoking class";
}

public class BookedFlightInfo
{
    [Display(Name = "FlightNumber")]
    public string FlightNumber { set; get; }

    [Display(Name = "SeatList")]
    public string SeatList { set; get; }

    [Display(Name = "IsReturning")]
    public bool IsReturning { set; get; }

    [Display(Name = "SequenceNumber")]
    public int SequenceNumber { set; get; }

    [Display(Name = "Class")]
    public string Class { set; get; }

    [Display(Name = "Passengers")]
    public List<int> Passengers { set; get; }
}