<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Weather.ascx.cs" Inherits="Khadmatcom.Controls.Weather" %>

<div id="divWeather">
    <h3 id="location">Weather In Hurghada
       
    </h3>
    <div id="temerature">
        <img src="#" alt="" id="imgWeatherFlag" />
        <span id="weatherDesc"></span><span id="temp_C"></span>
    </div>
    <div id="wind">
        <span id="local_time"></span>
        <br />
        <span id="windspeedKmph"></span>
    </div>
    <div style="display: none;" id="nextday">
    </div>
</div>
