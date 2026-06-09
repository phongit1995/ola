.class Lchat/ola/vn/balloon/OlaBalloonService$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/OlaBalloonService;->a()V
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

    iput-object p1, p0, Lchat/ola/vn/balloon/OlaBalloonService$2;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$2;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$2;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/balloon/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/balloon/OlaBalloonService$2;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v2, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_1
    :cond_0
    return-void
.end method
