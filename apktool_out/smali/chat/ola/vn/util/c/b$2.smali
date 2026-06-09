.class final Lchat/ola/vn/util/c/b$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/support/v4/app/NotificationCompat$Builder;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:I


# direct methods
.method constructor <init>(Landroid/support/v4/app/NotificationCompat$Builder;Landroid/content/Context;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/c/b$2;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    iput-object p2, p0, Lchat/ola/vn/util/c/b$2;->b:Landroid/content/Context;

    iput p3, p0, Lchat/ola/vn/util/c/b$2;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/util/c/b$2;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object p1, p0, Lchat/ola/vn/util/c/b$2;->b:Landroid/content/Context;

    const-string v0, "notification"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    iget v0, p0, Lchat/ola/vn/util/c/b$2;->c:I

    iget-object v1, p0, Lchat/ola/vn/util/c/b$2;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/util/c/b$2;->b:Landroid/content/Context;

    const-string v0, "notification"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/NotificationManager;

    iget v0, p0, Lchat/ola/vn/util/c/b$2;->c:I

    iget-object v1, p0, Lchat/ola/vn/util/c/b$2;->a:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v1}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method
