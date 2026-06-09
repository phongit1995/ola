.class Lchat/ola/vn/service/OlaLikeOnNotificationService$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/service/OlaLikeOnNotificationService;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/support/v4/app/NotificationCompat$Builder;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/message/f;

.field final synthetic d:Lchat/ola/vn/service/OlaLikeOnNotificationService;


# direct methods
.method constructor <init>(Lchat/ola/vn/service/OlaLikeOnNotificationService;Landroid/support/v4/app/NotificationCompat$Builder;Landroid/content/Context;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->d:Lchat/ola/vn/service/OlaLikeOnNotificationService;

    iput-object p2, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    iput-object p3, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->b:Landroid/content/Context;

    iput-object p4, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->c:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object p1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->b:Landroid/content/Context;

    const-string v0, "notification"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    iget-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/16 v1, 0x75

    invoke-virtual {p1, v1, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->c:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->i()S

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->i()S

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->b:Landroid/content/Context;

    const-string v0, "notification"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    const/16 v0, 0x75

    iget-object v1, p0, Lchat/ola/vn/service/OlaLikeOnNotificationService$1;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method
