.class Lchat/ola/vn/balloon/OlaBalloonService$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/OlaBalloonService;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/balloon/OlaBalloonService;


# direct methods
.method constructor <init>(Lchat/ola/vn/balloon/OlaBalloonService;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/OlaBalloonService$1;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$1;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->c:Landroid/os/Handler;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->o()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    iget-object v2, p0, Lchat/ola/vn/balloon/OlaBalloonService$1;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v2, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;)V

    goto :goto_0

    :cond_0
    return-void
.end method
