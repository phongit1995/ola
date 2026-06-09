.class Lchat/ola/vn/activity/OlaVipStoreActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaVipStoreActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

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

    new-instance p1, Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaVipStoreActivity;->g:Ljava/lang/Short;

    invoke-virtual {p2}, Ljava/lang/Short;->shortValue()S

    move-result p2

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity$1;S)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_0

    int-to-short p3, p3

    invoke-static {p1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(SS)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->C()V

    return-void
.end method
