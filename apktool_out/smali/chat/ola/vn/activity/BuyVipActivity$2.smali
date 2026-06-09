.class Lchat/ola/vn/activity/BuyVipActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$2;->a:Lchat/ola/vn/activity/BuyVipActivity;

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

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$2;->a:Lchat/ola/vn/activity/BuyVipActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$2;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->g(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/ad;

    move-result-object p2

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/ad;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/BuyVipActivity;->a(Lchat/ola/vn/activity/BuyVipActivity;Lchat/ola/vn/entity/ah;)Lchat/ola/vn/entity/ah;

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$2;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/BuyVipActivity;->B()V

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$2;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->h(Lchat/ola/vn/activity/BuyVipActivity;)Lcom/mg/ola/common/widget/b;

    move-result-object p1

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b;->d()V

    return-void
.end method
