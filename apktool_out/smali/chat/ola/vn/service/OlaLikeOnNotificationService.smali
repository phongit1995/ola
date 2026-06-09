.class public Lchat/ola/vn/service/OlaLikeOnNotificationService;
.super Landroid/app/Service;

# interfaces
.implements Lchat/ola/vn/f/a;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Z

.field private c:Ljava/lang/String;

.field private d:J


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->c:Ljava/lang/String;

    return-void
.end method

.method private a()V
    .locals 13

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v1, v0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v2

    if-nez v2, :cond_0

    new-instance v2, Lchat/ola/vn/message/f;

    iget-object v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    invoke-direct {v2, v3, v4}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_0
    const v3, 0x7f0f0023

    invoke-virtual {v0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    const v3, 0x7f08074c

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->c:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_1
    new-instance v5, Landroid/content/Intent;

    const-class v6, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {v5, v0, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v6, 0x50800000

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v6, "_me_entry_id"

    iget-wide v7, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    invoke-virtual {v5, v6, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    const-string v6, "_index"

    const/16 v7, 0x75

    invoke-virtual {v5, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v6, "chat.ola.vn.ACTION_VIEW_ME"

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v6, 0x8000000

    invoke-static {v0, v4, v5, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v5

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v8

    const/4 v9, 0x1

    if-eqz v8, :cond_3

    new-instance v8, Landroid/support/v4/app/NotificationCompat$BigTextStyle;

    invoke-direct {v8}, Landroid/support/v4/app/NotificationCompat$BigTextStyle;-><init>()V

    invoke-virtual {v8, v3}, Landroid/support/v4/app/NotificationCompat$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$BigTextStyle;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->setStyle(Landroid/support/v4/app/NotificationCompat$Style;)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v3, Landroid/content/Intent;

    const-class v8, Lchat/ola/vn/activity/OlaReplyMeOnNotificationActivity;

    invoke-direct {v3, v0, v8}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v8, 0x10000000

    invoke-virtual {v3, v8}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v10, "chat.ola.vn.ACTION_VIEW_ME"

    invoke-virtual {v3, v10}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v10, "_me_entry_id"

    iget-wide v11, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    invoke-virtual {v3, v10, v11, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    const-string v10, "_sender"

    iget-object v11, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    invoke-virtual {v3, v10, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v10, "me_message"

    iget-object v11, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->c:Ljava/lang/String;

    invoke-virtual {v3, v10, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v10, "_index"

    invoke-virtual {v3, v10, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v10, "_action"

    invoke-virtual {v3, v10, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    invoke-static {v0, v4, v3, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    const v10, 0x7f080641

    const v11, 0x7f0f05ea

    invoke-virtual {v0, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v1, v10, v11, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    new-instance v3, Landroid/content/Intent;

    const-class v10, Lchat/ola/vn/service/OlaLikeOnNotificationService;

    invoke-direct {v3, v0, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v3, v8}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v8, "chat.ola.vn.ACTION_VIEW_ME"

    invoke-virtual {v3, v8}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v8, "_me_entry_id"

    iget-wide v10, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    invoke-virtual {v3, v8, v10, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    const-string v8, "me_like_state"

    iget-boolean v10, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    invoke-virtual {v3, v8, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v8, "_sender"

    iget-object v10, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    invoke-virtual {v3, v8, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v8, "me_message"

    iget-object v10, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->c:Ljava/lang/String;

    invoke-virtual {v3, v8, v10}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-static {v0, v4, v3, v6}, Landroid/app/PendingIntent;->getService(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    iget-boolean v6, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    const v8, 0x7f0f0536

    if-eqz v6, :cond_2

    const v6, 0x7f080702

    invoke-virtual {v0, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    :goto_0
    invoke-virtual {v1, v6, v8, v3}, Landroid/support/v4/app/NotificationCompat$Builder;->addAction(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    goto :goto_1

    :cond_2
    const v6, 0x7f080701

    invoke-virtual {v0, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v8

    goto :goto_0

    :goto_1
    invoke-virtual {v1, v4}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_3
    invoke-virtual {v1, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    invoke-virtual {v5, v3}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v5

    if-eqz v5, :cond_4

    invoke-virtual {v1, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {v0, v7, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void

    :cond_4
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f0806a5

    invoke-static {v5, v6}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-static {v3}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v3

    new-instance v5, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;

    invoke-direct {v5, p0, v1, v0, v2}, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;-><init>(Lchat/ola/vn/service/OlaLikeOnNotificationService;Landroid/support/v4/app/NotificationCompat$Builder;Landroid/content/Context;Lchat/ola/vn/message/f;)V

    invoke-virtual {v3, v5}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance v0, Lchat/ola/vn/c/e;

    invoke-direct {v0}, Lchat/ola/vn/c/e;-><init>()V

    new-array v1, v9, [Lchat/ola/vn/c/f;

    aput-object v3, v1, v4

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 0

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 5

    :try_start_0
    const-string v0, "_me_entry_id"

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v3

    iput-wide v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    const-string v0, "_sender"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a:Ljava/lang/String;

    const-string v0, "me_message"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->c:Ljava/lang/String;

    iget-wide v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    cmp-long v0, v3, v1

    if-eqz v0, :cond_2

    const-string v0, "me_like_state"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    iget-boolean v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    iget-boolean v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    :goto_0
    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    goto :goto_1

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->d:J

    iget-boolean v3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    goto :goto_0

    :cond_1
    :goto_1
    iget-boolean v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService;->b:Z

    invoke-direct {p0}, Lchat/ola/vn/service/OlaLikeOnNotificationService;->a()V

    goto :goto_2

    :cond_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_2
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    move-result p1

    return p1
.end method
