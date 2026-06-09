.class public Lchat/ola/vn/util/c/b;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/util/c/a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field public static C:I = 0x6

.field public static D:I

.field private static E:Ljava/lang/Runnable;

.field private static F:J

.field private static G:Ljava/lang/Runnable;

.field private static H:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a()V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {}, Lchat/ola/vn/c/x;->f()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v3, Lchat/ola/vn/util/c/b;->a:[J

    :goto_0
    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setVibrate([J)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_0
    sget-object v3, Lchat/ola/vn/util/c/b;->b:[J

    goto :goto_0

    :cond_1
    :goto_1
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v3, Lchat/ola/vn/util/c/b;->r:Landroid/net/Uri;

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_2
    sget-boolean v3, Lchat/ola/vn/c/x;->q:Z

    if-eqz v3, :cond_3

    const v3, -0xff0100

    sget-object v4, Lchat/ola/vn/util/c/b;->g:[I

    const/4 v5, 0x0

    aget v4, v4, v5

    sget-object v5, Lchat/ola/vn/util/c/b;->g:[I

    aget v2, v5, v2

    invoke-virtual {v1, v3, v4, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setLights(III)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_3
    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/16 v2, 0x64

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(I)V
    .locals 5

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {}, Lchat/ola/vn/c/x;->f()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v3, Lchat/ola/vn/util/c/b;->a:[J

    :goto_0
    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setVibrate([J)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_0
    sget-object v3, Lchat/ola/vn/util/c/b;->b:[J

    goto :goto_0

    :cond_1
    :goto_1
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-static {}, Lchat/ola/vn/c/x;->d()Landroid/net/Uri;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_2
    if-ne p0, v2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v3, p0

    const-string p0, ","

    invoke-static {v3, v4, p0}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, " "

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p0, 0x7f0f0679

    invoke-virtual {v0, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_3

    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v3, p0

    const-string p0, ","

    invoke-static {v3, v4, p0}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, " "

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p0, 0x7f0f067a

    invoke-virtual {v0, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    :goto_3
    const v2, 0x7f0f0023

    invoke-virtual {v0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v2, 0x7f08074a

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance p0, Landroid/content/Intent;

    const-class v2, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p0, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "chat.ola.vn.ACTION_SHOW_CONVERSATION"

    invoke-virtual {p0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v2, 0x50800000

    invoke-virtual {p0, v2}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const/4 v2, 0x0

    const/high16 v3, 0x8000000

    invoke-static {v0, v2, p0, v3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string p0, "notification"

    invoke-virtual {v0, p0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    const/16 v0, 0x64

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;I)V

    return-void
.end method

.method public static a(Landroid/content/Context;I)V
    .locals 1

    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    if-nez p1, :cond_0

    invoke-virtual {p0}, Landroid/app/NotificationManager;->cancelAll()V

    return-void

    :cond_0
    invoke-virtual {p0, p1}, Landroid/app/NotificationManager;->cancel(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static a(Landroid/content/Context;J)V
    .locals 1

    :try_start_0
    const-string v0, "vibrator"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/os/Vibrator;

    invoke-virtual {p0, p1, p2}, Landroid/os/Vibrator;->vibrate(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static a(Landroid/content/Context;JJIII)V
    .locals 4

    :try_start_0
    const-string p5, "notification"

    invoke-virtual {p0, p5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Landroid/app/NotificationManager;

    new-instance p7, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {p7, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {p7, p6}, Landroid/support/v4/app/NotificationCompat$Builder;->setNumber(I)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p6

    const v0, 0x7f0f0389

    invoke-virtual {p6, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p6

    invoke-virtual {p7, p6}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-wide/16 v0, 0x0

    cmp-long p6, p3, v0

    const/4 v0, 0x0

    if-eqz p6, :cond_0

    const-wide/16 v1, 0x64

    mul-long v1, v1, p1

    div-long/2addr v1, p3

    long-to-int p6, v1

    goto :goto_0

    :cond_0
    const/4 p6, 0x0

    :goto_0
    const/16 v1, 0x64

    invoke-virtual {p7, v1, p6, v0}, Landroid/support/v4/app/NotificationCompat$Builder;->setProgress(IIZ)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0f0352

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, p1, p2}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v3, v0

    invoke-static {p0, p3, p4}, Landroid/text/format/Formatter;->formatShortFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    aput-object p1, v3, p2

    const/4 p1, 0x2

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p4, "%"

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, v3, p1

    invoke-virtual {v1, v2, v3}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p7, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    sget p1, Lchat/ola/vn/util/c/b;->D:I

    add-int/2addr p1, p2

    sput p1, Lchat/ola/vn/util/c/b;->D:I

    sget p1, Lchat/ola/vn/util/c/b;->D:I

    sget p3, Lchat/ola/vn/util/c/b;->C:I

    if-lt p1, p3, :cond_1

    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    sget p1, Lchat/ola/vn/util/c/b;->D:I

    :goto_1
    sput p1, Lchat/ola/vn/util/c/b;->D:I

    const p1, 0x7f080754

    sget p3, Lchat/ola/vn/util/c/b;->D:I

    invoke-virtual {p7, p1, p3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(II)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p7, p2}, Landroid/support/v4/app/NotificationCompat$Builder;->setOngoing(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const/high16 p2, 0x8000000

    invoke-static {p0, v0, p1, p2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {p7, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/16 p0, 0x69

    invoke-virtual {p7}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {p5, p0, p1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    sget-object p0, Lchat/ola/vn/util/c/b;->G:Ljava/lang/Runnable;

    if-nez p0, :cond_2

    new-instance p0, Lchat/ola/vn/util/c/b$1;

    invoke-direct {p0, p5}, Lchat/ola/vn/util/c/b$1;-><init>(Landroid/app/NotificationManager;)V

    sput-object p0, Lchat/ola/vn/util/c/b;->G:Ljava/lang/Runnable;

    :cond_2
    sget-object p0, Lchat/ola/vn/util/c/b;->G:Ljava/lang/Runnable;

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    sget-object p0, Lchat/ola/vn/util/c/b;->G:Ljava/lang/Runnable;

    const-wide/16 p1, 0x2710

    invoke-static {p0, p1, p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v1, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    :goto_0
    invoke-virtual {v1, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v2, 0x7f0f02dc

    invoke-virtual {p1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v2, 0x7f0f0268

    invoke-virtual {p1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :goto_1
    const p1, 0x7f08074c

    invoke-virtual {v1, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 p1, 0x1

    invoke-virtual {v1, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 p1, 0x0

    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2}, Landroid/content/Intent;-><init>()V

    const/high16 v3, 0x8000000

    invoke-static {p0, p1, v2, v3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/16 p0, 0x70

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {v0, p0, p1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 3

    :try_start_0
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v0, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/util/c/b;->A:Landroid/net/Uri;

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    const v1, 0x7f0806fa

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const v1, 0x7f0f0315

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p3, p4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    const/4 p4, 0x0

    aput-object p3, v2, p4

    const/4 p3, 0x1

    aput-object p1, v2, p3

    const/4 p1, 0x2

    aput-object p2, v2, p1

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const p2, 0x7f0f0316

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0, p2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0, p3}, Landroid/support/v4/app/NotificationCompat$Builder;->setOnlyAlertOnce(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0, p3}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const/high16 p2, 0x8000000

    invoke-static {p0, p4, p1, p2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string p1, "notification"

    invoke-virtual {p0, p1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    const/16 p2, 0x64

    invoke-virtual {p1, p2}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    add-int/lit16 p1, p1, 0x12c

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result p2

    if-nez p2, :cond_1

    new-instance p2, Lchat/ola/vn/util/c/b$5;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/util/c/b$5;-><init>(Landroid/app/NotificationManager;I)V

    const-wide/32 p0, 0xea60

    invoke-static {p2, p0, p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public static a(Lchat/ola/vn/message/f;)V
    .locals 7

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f0f0023

    invoke-virtual {v0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f080735

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f0f02da

    new-array v4, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->c()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-virtual {v0, v3, v4}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    new-instance v3, Landroid/content/Intent;

    const-class v4, Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {v3, v0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    const-string v4, "_username"

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    const-string v4, "_conv_id"

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "_conv_type"

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->k()S

    move-result v5

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    const/high16 v4, 0x50800000

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const/high16 v4, 0x8000000

    invoke-static {v0, v6, v3, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v3, Ljava/util/Random;

    invoke-direct {v3}, Ljava/util/Random;-><init>()V

    const/16 v4, 0x64

    invoke-virtual {v3, v4}, Ljava/util/Random;->nextInt(I)I

    move-result v3

    add-int/lit16 v3, v3, 0x190

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    invoke-virtual {v4, p0}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v1, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_0

    :cond_2
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f0806a5

    invoke-static {v4, v5}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {p0}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object p0

    new-instance v4, Lchat/ola/vn/util/c/b$2;

    invoke-direct {v4, v1, v0, v3}, Lchat/ola/vn/util/c/b$2;-><init>(Landroid/support/v4/app/NotificationCompat$Builder;Landroid/content/Context;I)V

    invoke-virtual {p0, v4}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v4, Lchat/ola/vn/c/e;

    invoke-direct {v4}, Lchat/ola/vn/c/e;-><init>()V

    new-array v2, v2, [Lchat/ola/vn/c/f;

    aput-object p0, v2, v6

    invoke-virtual {v4, v2}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :goto_0
    :try_start_2
    const-string p0, "notification"

    invoke-virtual {v0, p0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    invoke-virtual {p0, v3, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->f(Lchat/ola/vn/message/f;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p0}, Lchat/ola/vn/util/c/b;->b(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_1
    if-eqz p1, :cond_2

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/util/c/b;->a()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :try_start_2
    invoke-static {p0, p1}, Lchat/ola/vn/util/c/b;->b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const v2, 0x7f08074c

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const v2, 0x7f0f0023

    invoke-virtual {v0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 p0, 0x1

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setOnlyAlertOnce(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p0

    const/4 v2, 0x0

    if-nez p0, :cond_2

    new-instance p0, Landroid/content/Intent;

    const-class v3, Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0, v0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    const-string v3, "_username"

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    const-string v3, "_conv_id"

    invoke-virtual {p0, v3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_conv_type"

    invoke-virtual {p0, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    const/high16 p1, 0x8000000

    invoke-static {v0, v2, p0, p1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    :goto_0
    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_2
    new-instance p0, Landroid/content/Intent;

    invoke-direct {p0}, Landroid/content/Intent;-><init>()V

    invoke-static {v0, v2, p0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    goto :goto_0

    :goto_1
    const-string p0, "notification"

    invoke-virtual {v0, p0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    const/16 p1, 0x66

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    sget-object p1, Lchat/ola/vn/util/c/b;->E:Ljava/lang/Runnable;

    if-nez p1, :cond_3

    new-instance p1, Lchat/ola/vn/util/c/b$4;

    invoke-direct {p1, p0}, Lchat/ola/vn/util/c/b$4;-><init>(Landroid/app/NotificationManager;)V

    sput-object p1, Lchat/ola/vn/util/c/b;->E:Ljava/lang/Runnable;

    :cond_3
    sget-object p0, Lchat/ola/vn/util/c/b;->E:Ljava/lang/Runnable;

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    sget-object p0, Lchat/ola/vn/util/c/b;->E:Ljava/lang/Runnable;

    const-wide/16 v0, 0xbb8

    invoke-static {p0, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {}, Lchat/ola/vn/c/x;->d()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/16 v2, 0x64

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static b(I)V
    .locals 7

    :try_start_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p0}, Lchat/ola/vn/e;->f(I)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p0}, Lchat/ola/vn/e;->g(I)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f0f0023

    invoke-virtual {v0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f08074c

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f0f037f

    const/4 v4, 0x0

    if-gtz p0, :cond_1

    new-array p0, v2, [Ljava/lang/Object;

    const-string v2, ""

    aput-object v2, p0, v4

    invoke-virtual {v0, v3, p0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_1
    new-array v2, v2, [Ljava/lang/Object;

    int-to-long v5, p0

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p0

    aput-object p0, v2, v4

    invoke-virtual {v0, v3, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    :goto_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_2
    new-instance p0, Landroid/content/Intent;

    const-class v2, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p0, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    const-string v2, "_username"

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "chat.ola.vn.ACTION_VIEW_ME"

    invoke-virtual {p0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "_me_entry_id"

    invoke-virtual {p0, v2, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 v2, 0x10020000

    invoke-virtual {p0, v2}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const/high16 v2, 0x8000000

    invoke-static {v0, v4, p0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string p0, "notification"

    invoke-virtual {v0, p0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    const/16 v0, 0x75

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method public static b(Landroid/content/Context;)V
    .locals 5

    if-nez p0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_1

    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f0280

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f0397

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v2, 0x7f08074b

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v2, Landroid/content/Intent;

    const-class v3, Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {v2, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v3, 0x0

    const/high16 v4, 0x8000000

    invoke-static {p0, v3, v2, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/16 p0, 0x74

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public static b(Landroid/content/Context;I)V
    .locals 1

    if-gez p1, :cond_0

    const/4 p1, 0x0

    :cond_0
    const/16 v0, 0x63

    if-le p1, v0, :cond_1

    const/16 p1, 0x63

    :cond_1
    :try_start_0
    sget v0, Lchat/ola/vn/util/c/b;->H:I

    if-nez v0, :cond_2

    if-nez p1, :cond_2

    return-void

    :cond_2
    sput p1, Lchat/ola/vn/util/c/b;->H:I

    invoke-static {p0, p1}, Lchat/ola/vn/badger/j;->a(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v0, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/util/c/b;->A:Landroid/net/Uri;

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    const-string v1, "notification"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;S)I

    move-result p1

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private static b(Lchat/ola/vn/message/f;)V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->N()Z

    move-result v2

    if-eqz v2, :cond_0

    sget-object v2, Lchat/ola/vn/util/c/b;->l:Landroid/net/Uri;

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->U()I

    move-result p0

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 17

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->W()Z

    move-result v2

    if-nez v2, :cond_0

    return-void

    :cond_0
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->z()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-nez v2, :cond_1

    return-void

    :cond_1
    if-lez v2, :cond_2

    :try_start_1
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->c()Lchat/ola/vn/c;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {v3}, Lchat/ola/vn/activity/OlaBottomTabActivity;->L()I

    move-result v3

    if-nez v3, :cond_2

    invoke-static {}, Lchat/ola/vn/m/e;->c()Lchat/ola/vn/m/e;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/m/e;->d()S

    move-result v3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-nez v3, :cond_2

    return-void

    :catch_0
    :cond_2
    :try_start_2
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v3

    sget-byte v4, Lchat/ola/vn/c/x;->k:B

    const/4 v5, 0x2

    if-ne v4, v5, :cond_3

    return-void

    :cond_3
    new-instance v4, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v4, v3}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v6, 0x1

    invoke-virtual {v4, v6}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const v7, 0x7f08074a

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v8

    const v9, 0x7f080749

    if-ne v8, v5, :cond_4

    const v7, 0x7f080749

    :cond_4
    sget-boolean v8, Lchat/ola/vn/c/x;->q:Z

    const/4 v10, 0x0

    if-eqz v8, :cond_5

    const v8, -0xff0100

    sget-object v11, Lchat/ola/vn/util/c/b;->d:[I

    aget v11, v11, v10

    sget-object v12, Lchat/ola/vn/util/c/b;->d:[I

    aget v12, v12, v6

    invoke-virtual {v4, v8, v11, v12}, Landroid/support/v4/app/NotificationCompat$Builder;->setLights(III)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_5
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->P()Z

    move-result v8

    if-eqz v8, :cond_6

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->x()Z

    move-result v8

    if-nez v8, :cond_6

    sget-object v8, Lchat/ola/vn/util/c/b;->a:[J

    invoke-virtual {v4, v8}, Landroid/support/v4/app/NotificationCompat$Builder;->setVibrate([J)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_6
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->N()Z

    move-result v8

    if-eqz v8, :cond_9

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->x()Z

    move-result v8

    if-nez v8, :cond_9

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v8

    sget-object v11, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    invoke-static {v8, v11}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_8

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    sget-wide v13, Lchat/ola/vn/util/c/b;->F:J

    const/4 v8, 0x0

    sub-long v15, v11, v13

    const-wide/32 v13, 0x2bf20

    cmp-long v8, v15, v13

    if-gez v8, :cond_7

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->O()Landroid/net/Uri;

    move-result-object v8

    :goto_0
    invoke-virtual {v4, v8}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_7
    sget-object v8, Lchat/ola/vn/util/c/b;->k:Landroid/net/Uri;

    goto :goto_0

    :goto_1
    sput-wide v11, Lchat/ola/vn/util/c/b;->F:J

    goto :goto_2

    :cond_8
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->O()Landroid/net/Uri;

    move-result-object v8

    invoke-virtual {v4, v8}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :goto_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    iput-wide v11, v0, Lchat/ola/vn/message/f;->r:J

    :cond_9
    const v8, 0x7f0f0317

    const v11, 0x7f0f067a

    const v12, 0x7f0f0466

    if-eqz v1, :cond_15

    const/4 v13, 0x0

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v15

    if-nez v15, :cond_a

    invoke-static {v14}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v15

    if-eqz v15, :cond_a

    invoke-interface {v15}, Ljava/util/List;->size()I

    move-result v16

    if-lez v16, :cond_a

    invoke-interface {v15, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    new-instance v15, Lchat/ola/vn/entity/i;

    invoke-direct {v15}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v15, v13}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    move-object v13, v15

    :cond_a
    if-ne v2, v6, :cond_11

    const v2, 0x7f0f0318

    const v8, 0x7f0f031f

    if-eqz v13, :cond_c

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v11

    if-ne v11, v5, :cond_b

    invoke-virtual {v13}, Lchat/ola/vn/entity/i;->f()S

    move-result v2

    packed-switch v2, :pswitch_data_0

    new-array v2, v5, [Ljava/lang/Object;

    goto :goto_4

    :pswitch_0
    const v2, 0x7f0f031c

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    :goto_3
    invoke-virtual {v3, v2, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    goto :goto_6

    :pswitch_1
    const v2, 0x7f0f0320

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    goto :goto_3

    :pswitch_2
    const v2, 0x7f0f0319

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    goto :goto_3

    :goto_4
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v6

    :goto_5
    invoke-virtual {v3, v8, v2}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    :goto_6
    const v7, 0x7f080749

    goto/16 :goto_c

    :cond_b
    invoke-virtual {v13}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    packed-switch v5, :pswitch_data_1

    new-array v5, v6, [Ljava/lang/Object;

    goto :goto_7

    :pswitch_3
    const v2, 0x7f0f031e

    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual {v3, v2, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const v9, 0x7f080746

    const v7, 0x7f080746

    goto/16 :goto_c

    :pswitch_4
    const v2, 0x7f0f0322

    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual {v3, v2, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const v9, 0x7f080744

    const v7, 0x7f080744

    goto/16 :goto_c

    :pswitch_5
    const v2, 0x7f0f031b

    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v10

    invoke-virtual {v3, v2, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const v9, 0x7f080741

    const v7, 0x7f080741

    goto/16 :goto_c

    :goto_7
    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v8

    aput-object v8, v5, v10

    :goto_8
    invoke-virtual {v3, v2, v5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_c

    :cond_c
    invoke-static {v14}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_e

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v5, :cond_d

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v6

    goto :goto_5

    :cond_d
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_9
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_c

    :cond_e
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v11

    if-ne v11, v5, :cond_f

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v10

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v6

    goto/16 :goto_5

    :cond_f
    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->o()S

    move-result v5

    if-lez v5, :cond_10

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v5, 0x7f0f0636

    invoke-virtual {v3, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    :goto_a
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_9

    :cond_10
    new-array v5, v6, [Ljava/lang/Object;

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v8

    aput-object v8, v5, v10

    goto :goto_8

    :cond_11
    if-lez v2, :cond_13

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v8

    if-ne v8, v5, :cond_12

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, " "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ": "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v8, v2

    const-string v2, ","

    invoke-static {v8, v9, v2}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_b
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_c

    :cond_12
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v8, v2

    const-string v2, ","

    invoke-static {v8, v9, v2}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_b

    :cond_13
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v5, :cond_14

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    goto/16 :goto_a

    :cond_14
    invoke-virtual {v3, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_c

    :cond_15
    if-lez v2, :cond_17

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v8

    if-ne v8, v5, :cond_16

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, " "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ": "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v8, v2

    const-string v2, ","

    invoke-static {v8, v9, v2}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_b

    :cond_16
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v8, v2

    const-string v2, ","

    invoke-static {v8, v9, v2}, Lchat/ola/vn/util/m;->a(JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_b

    :cond_17
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v5, :cond_14

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    goto/16 :goto_a

    :goto_c
    invoke-virtual {v4, v7}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const v5, 0x7f0f0023

    invoke-virtual {v3, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v4, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v4, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v2, Landroid/content/Intent;

    const-class v5, Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {v2, v3, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_18

    const-string v5, "_username"

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v5, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_18
    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "_conv_id"

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v5, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "_conv_type"

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->k()S

    move-result v7

    invoke-virtual {v2, v5, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    const/high16 v5, 0x8000000

    invoke-static {v3, v10, v2, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v4, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual/range {p1 .. p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v2

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    invoke-virtual {v5, v2}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v5

    if-eqz v5, :cond_19

    invoke-virtual {v4, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_d

    :cond_19
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v7, 0x7f0806a5

    invoke-static {v5, v7}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {v2}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v2

    new-instance v5, Lchat/ola/vn/util/c/b$3;

    invoke-direct {v5, v4, v3, v0, v1}, Lchat/ola/vn/util/c/b$3;-><init>(Landroid/support/v4/app/NotificationCompat$Builder;Landroid/content/Context;Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V

    invoke-virtual {v2, v5}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    new-instance v1, Lchat/ola/vn/c/e;

    invoke-direct {v1}, Lchat/ola/vn/c/e;-><init>()V

    new-array v5, v6, [Lchat/ola/vn/c/f;

    aput-object v2, v5, v10

    invoke-virtual {v1, v5}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_d
    :try_start_4
    const-string v1, "notification"

    invoke-virtual {v3, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    invoke-virtual/range {p0 .. p0}, Lchat/ola/vn/message/f;->U()I

    move-result v0

    invoke-virtual {v4}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method

.method public static c()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/x;->f()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    sget-object v2, Lchat/ola/vn/util/c/b;->a:[J

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setVibrate([J)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/16 v2, 0x64

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static c(Landroid/content/Context;)V
    .locals 5

    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f0280

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f01f5

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v2, 0x7f08074c

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 v2, 0x0

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const/high16 v4, 0x8000000

    invoke-static {p0, v2, v3, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/16 p0, 0x73

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v0, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/util/c/b;->B:Landroid/net/Uri;

    invoke-virtual {v0, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setSound(Landroid/net/Uri;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    const-string v1, "notification"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;S)I

    move-result p1

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static d(Landroid/content/Context;)V
    .locals 1

    const/16 v0, 0x73

    :try_start_0
    invoke-static {p0, v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static e(Landroid/content/Context;)V
    .locals 5

    :try_start_0
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x7f0f02db

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v2, 0x7f08074c

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    const/4 v2, 0x0

    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const/high16 v4, 0x8000000

    invoke-static {p0, v2, v3, v4}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    const/16 p0, 0x70

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static f(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0, v0}, Lchat/ola/vn/badger/j;->a(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
