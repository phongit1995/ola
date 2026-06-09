.class public Lchat/ola/vn/tradingvip/b;
.super Lchat/ola/vn/tradingvip/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# static fields
.field private static d:I = -0x1

.field private static e:I = -0x1


# instance fields
.field protected a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation
.end field

.field private b:Landroid/widget/ListView;

.field private c:Lchat/ola/vn/b/ad;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/tradingvip/b;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    return-object p0
.end method

.method private e(Ljava/lang/String;)V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/b;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    new-instance v1, Lchat/ola/vn/tradingvip/b$1;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/tradingvip/b$1;-><init>(Lchat/ola/vn/tradingvip/b;Ljava/lang/String;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->j(Ljava/lang/String;S)V

    :cond_0
    return-void
.end method

.method static synthetic v()I
    .locals 1

    sget v0, Lchat/ola/vn/tradingvip/b;->e:I

    return v0
.end method

.method static synthetic x()I
    .locals 1

    sget v0, Lchat/ola/vn/tradingvip/b;->d:I

    return v0
.end method


# virtual methods
.method public a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IS",
            "Ljava/lang/String;",
            "J",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;)V"
        }
    .end annotation

    new-instance p1, Ljava/util/ArrayList;

    invoke-interface {p7}, Ljava/util/List;->size()I

    move-result p2

    invoke-direct {p1, p2}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/tradingvip/b;->a:Ljava/util/List;

    invoke-interface {p7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    const/4 p2, 0x0

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entity/ah;

    invoke-virtual {p3}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object p5

    invoke-static {p5, p4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p5

    if-nez p5, :cond_1

    iget-object p5, p0, Lchat/ola/vn/tradingvip/b;->a:Ljava/util/List;

    invoke-interface {p5, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    move-object p2, p3

    :goto_1
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p5

    invoke-virtual {p3}, Lchat/ola/vn/entity/ah;->b()I

    move-result p6

    invoke-virtual {p5, p6}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p5

    if-eqz p5, :cond_0

    invoke-virtual {p5}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p3, p5}, Lchat/ola/vn/entity/ah;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    iget-object p3, p0, Lchat/ola/vn/tradingvip/b;->a:Ljava/util/List;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/ad;->a(Ljava/util/List;)V

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    invoke-virtual {p2}, Lchat/ola/vn/entity/ah;->b()I

    move-result p3

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/ad;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    invoke-virtual {p2}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/b/ad;->a(Ljava/lang/String;)V

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    invoke-virtual {p1}, Lchat/ola/vn/b/ad;->notifyDataSetChanged()V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/tradingvip/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/tradingvip/a;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/tradingvip/c;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tradingvip/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0610

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/b;->j()V

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const/4 p2, 0x0

    const p3, 0x7f0b0176

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p3, 0x7f0905f0

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ListView;

    iput-object p3, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    iget-object p3, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    invoke-virtual {p3, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance p3, Lchat/ola/vn/b/ad;

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p3, v0}, Lchat/ola/vn/b/ad;-><init>(Landroid/content/Context;)V

    iput-object p3, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    iget-object p3, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    const/4 v0, 0x0

    invoke-virtual {p3, v0}, Lchat/ola/vn/b/ad;->a(Z)V

    iget-object p3, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/tradingvip/b;->c:Lchat/ola/vn/b/ad;

    invoke-virtual {p3, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-direct {p0, p2}, Lchat/ola/vn/tradingvip/b;->e(Ljava/lang/String;)V

    return-object p1
.end method

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
    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ah;

    sput-object p1, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/b;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onResume()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/tradingvip/a;->onResume()V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/tradingvip/b$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/tradingvip/b$2;-><init>(Lchat/ola/vn/tradingvip/b;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/tradingvip/b;->b:Landroid/widget/ListView;

    const/4 p3, 0x0

    invoke-virtual {p1, p3}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p3

    :goto_0
    sput p3, Lchat/ola/vn/tradingvip/b;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sput p2, Lchat/ola/vn/tradingvip/b;->e:I

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method
