.class Lchat/ola/vn/view/i$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/m;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/i;->b(Lchat/ola/vn/entity/v;)V
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

    iput-object p1, p0, Lchat/ola/vn/view/i$2;->a:Lchat/ola/vn/view/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/v;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/v;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/w;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/view/i$2;->a:Lchat/ola/vn/view/i;

    invoke-static {v0}, Lchat/ola/vn/view/i;->d(Lchat/ola/vn/view/i;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz p2, :cond_0

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/v;->a(Ljava/util/List;)V

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/view/i$2;->a:Lchat/ola/vn/view/i;

    invoke-static {p2}, Lchat/ola/vn/view/i;->b(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$f;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/i$f;->a(Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/v;",
            ">;)V"
        }
    .end annotation

    return-void
.end method
