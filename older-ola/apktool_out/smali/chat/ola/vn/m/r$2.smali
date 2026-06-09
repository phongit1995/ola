.class Lchat/ola/vn/m/r$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/r;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/r;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/r;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/r$2;->a:Lchat/ola/vn/m/r;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/m/r$2;->a:Lchat/ola/vn/m/r;

    invoke-virtual {p2}, Lchat/ola/vn/m/r;->c()V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    iget-object p2, p0, Lchat/ola/vn/m/r$2;->a:Lchat/ola/vn/m/r;

    invoke-virtual {p2}, Lchat/ola/vn/m/r;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/r$2$1;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/r$2$1;-><init>(Lchat/ola/vn/m/r$2;)V

    invoke-virtual {p2, p3, p1, p4}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
