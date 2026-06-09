.class Lchat/ola/vn/m/j$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$1;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)Z"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    iget-object p2, p0, Lchat/ola/vn/m/j$1;->a:Lchat/ola/vn/m/j;

    const/4 p3, 0x1

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;Z)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p3

    :catch_0
    const/4 p1, 0x0

    return p1
.end method
