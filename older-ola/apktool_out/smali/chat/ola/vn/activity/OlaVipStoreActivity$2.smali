.class Lchat/ola/vn/activity/OlaVipStoreActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/entity/ah;Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/entity/ah;

.field final synthetic c:Lchat/ola/vn/activity/OlaVipStoreActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Ljava/util/List;Lchat/ola/vn/entity/ah;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p3, 0x7f0f0684

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/entity/ah;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p3, 0x7f0f0676

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x0

    const/4 p4, 0x1

    if-eqz p2, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    new-array p2, p4, [Ljava/lang/String;

    iget-object p4, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p4}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object p4

    aput-object p4, p2, p3

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->b([Ljava/lang/String;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/activity/OlaVipStoreActivity;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p5, 0x7f0f0546

    invoke-virtual {p2, p5}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    new-array p2, p4, [Ljava/lang/String;

    iget-object p4, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p4}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object p4

    aput-object p4, p2, p3

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->a([Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p3, 0x7f0f0657

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const p3, 0x7f0f0395

    const p4, 0x7f0f00a2

    if-eqz p2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->f()Z

    move-result p1

    if-eqz p1, :cond_3

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-static {p1, p4, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const/4 p2, 0x0

    iget-object p3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/ah;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p5, 0x7f0f04b3

    invoke-virtual {p2, p5}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->f()Z

    move-result p1

    if-eqz p1, :cond_5

    goto :goto_1

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->c:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$2;->b:Lchat/ola/vn/entity/ah;

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->b(Lchat/ola/vn/entity/ah;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method
