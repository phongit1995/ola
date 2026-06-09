.class Lchat/ola/vn/m/w$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$1;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 1

    const/4 p1, 0x1

    if-eq p2, p1, :cond_0

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/w$1;->a:Lchat/ola/vn/m/w;

    invoke-virtual {p1}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/w$1;->a:Lchat/ola/vn/m/w;

    invoke-static {p2}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object p2

    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    :cond_1
    return-void
.end method
