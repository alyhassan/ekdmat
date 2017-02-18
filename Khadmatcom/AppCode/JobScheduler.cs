using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common.Logging.Configuration;
using Quartz;
using Quartz.Impl;

namespace Khadmatcom.AppCode
{
    public static class JobScheduler
    {
        public static void Start(ITrigger trigger)
        {
            IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler();
            scheduler.Start();
            // define the job 
            IJobDetail job = JobBuilder.Create(typeof(Jobs)).Build();
            // Trigger the job to run now, and then every 40 seconds
            //ITrigger trigger = TriggerBuilder.Create().WithIdentity("myTrigger", "group1").StartNow().WithSimpleSchedule(x => x.WithIntervalInSeconds(40).RepeatForever()).Build();

            // Trigger the job to run now, and then every 6 hour
            //ITrigger trigger = TriggerBuilder.Create().WithIdentity("myTrigger", "group1").StartNow().WithSimpleSchedule(x => x.WithIntervalInHours(6).RepeatForever()).Build();

            // Tell quartz to schedule the job using our trigger
            scheduler.ScheduleJob(job, trigger);
        }

        public static void Start()
        {
            IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler();
            scheduler.Start();
            // define the job 
            IJobDetail job = JobBuilder.Create(typeof(Jobs)).Build();
            // Trigger the job to run now, and then every 40 seconds
            //ITrigger trigger = TriggerBuilder.Create().WithIdentity("myTrigger", "group1").StartNow().WithSimpleSchedule(x => x.WithIntervalInSeconds(40).RepeatForever()).Build();

            // Trigger the job to run now, and then every 6 hour
            ITrigger trigger = TriggerBuilder.Create().WithIdentity("myTrigger", "group1").StartNow().WithSimpleSchedule(x => x.WithIntervalInHours(6).RepeatForever()).Build();

            // Tell quartz to schedule the job using our trigger
            scheduler.ScheduleJob(job, trigger);
        }
    }
}