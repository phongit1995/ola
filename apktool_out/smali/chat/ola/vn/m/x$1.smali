.class Lchat/ola/vn/m/x$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/x;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/x;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/x$1;->a:Lchat/ola/vn/m/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/m/x$1;->a:Lchat/ola/vn/m/x;

    iget-object p1, p1, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/x$1;->a:Lchat/ola/vn/m/x;

    iget-object p1, p1, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    iget-object p2, p0, Lchat/ola/vn/m/x$1;->a:Lchat/ola/vn/m/x;

    invoke-static {p2}, Lchat/ola/vn/m/x;->a(Lchat/ola/vn/m/x;)Lchat/ola/vn/view/OlaListView;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/t;->a(Landroid/widget/ListView;)V

    :cond_0
    :pswitch_1
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method
