.class Lchat/ola/vn/balloon/OlaBalloonService$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/OlaBalloonService;->c()V
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

    iput-object p1, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/e/e;

    invoke-direct {v1}, Lchat/ola/vn/e/e;-><init>()V

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, v0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, v1, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/balloon/e;

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {v1, v2}, Lchat/ola/vn/balloon/e;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/balloon/OlaBalloonService$4;->a:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-static {v2, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/OlaBalloonService;Lchat/ola/vn/balloon/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    return-void
.end method
