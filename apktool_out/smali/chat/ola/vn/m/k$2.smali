.class Lchat/ola/vn/m/k$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/k;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/k;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/k;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x27

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {p1}, Lchat/ola/vn/m/k;->d(Lchat/ola/vn/m/k;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {p1}, Lchat/ola/vn/m/k;->e(Lchat/ola/vn/m/k;)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {p1}, Lchat/ola/vn/m/k;->f(Lchat/ola/vn/m/k;)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {v0}, Lchat/ola/vn/m/k;->d(Lchat/ola/vn/m/k;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {v0}, Lchat/ola/vn/m/k;->e(Lchat/ola/vn/m/k;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    const/4 v1, 0x0

    aget-object v1, p1, v1

    check-cast v1, [Lchat/ola/vn/entity/j;

    const/4 v2, 0x1

    aget-object p1, p1, v2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/m/k;->a(Lchat/ola/vn/m/k;[Lchat/ola/vn/entity/j;I)V

    iget-object p1, p0, Lchat/ola/vn/m/k$2;->a:Lchat/ola/vn/m/k;

    invoke-static {p1}, Lchat/ola/vn/m/k;->g(Lchat/ola/vn/m/k;)V

    return-void
.end method
