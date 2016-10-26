using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

public class Constants
{
    /// <summary>
    /// If the user is not logged in, the session value associated with this key will be null
    /// </summary>
    public const string SessionUserIDKey = "UserID";

    /// <summary>
    /// If the user is not an admin, the session value associated with this key will be null
    /// </summary>
    public const string SessionIsAdminLogged = "isAdmin";

    /// <summary>
    /// If the ticket is being rescheduled, store it number in this field
    /// </summary>
    public const string SessionRescheduledTicketKey = "RescheduledTicketNumber";
}

public class TicketStatus
{
    public const int Undefined = 0;
    public const int Confirmed = 1;
    public const int Cancelled = 2;
    public const int Blocked = 3;
    public const int Rescheduled = 4;
}

public class ClassNames
{
    public const string Any = "Any";
    public const string FirstClass = "First class";
    public const string BusinessClass = "Business class";
    public const string ClubClass = "Club class";
    public const string NonSmokingClass = "Non-smoking class";
    public const string SmokingClass = "Smoking class";
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