.class Lchat/ola/vn/m/m$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/m$a;->onVisibleActionBar(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/m/m$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/m$a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/m$a$1;->b:Lchat/ola/vn/m/m$a;

    iput-object p2, p0, Lchat/ola/vn/m/m$a$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    const-string v0, "1"

    iget-object v1, p0, Lchat/ola/vn/m/m$a$1;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/m$a$1;->b:Lchat/ola/vn/m/m$a;

    iget-object v0, v0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;Z)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/m$a$1;->b:Lchat/ola/vn/m/m$a;

    iget-object v0, v0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
