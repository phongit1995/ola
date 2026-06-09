.class Lchat/ola/vn/view/i$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/m;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/i;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/i;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$1;->a:Lchat/ola/vn/view/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/v;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/v;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/w;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/v;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/view/i;->b()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lchat/ola/vn/view/i$1;->a:Lchat/ola/vn/view/i;

    invoke-static {p1}, Lchat/ola/vn/view/i;->a(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/i$a;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/view/i$1;->a:Lchat/ola/vn/view/i;

    invoke-static {p1}, Lchat/ola/vn/view/i;->b(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/i$f;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/view/i$1$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/i$1$1;-><init>(Lchat/ola/vn/view/i$1;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
