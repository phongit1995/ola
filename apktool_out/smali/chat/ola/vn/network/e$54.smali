.class Lchat/ola/vn/network/e$54;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(ILjava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/util/List;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$54;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$54;->a:Ljava/util/List;

    iput p3, p0, Lchat/ola/vn/network/e$54;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$54;->a:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->j(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$54;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$54;->b:I

    iget-object v3, p0, Lchat/ola/vn/network/e$54;->a:Ljava/util/List;

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->a(ILjava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    return-void
.end method
