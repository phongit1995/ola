.class public Lchat/ola/vn/m/i;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/p/a;


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Landroid/view/View;

.field private c:Lchat/ola/vn/b/p;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:I

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 2

    const v0, 0x7f090319

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/m/i;->a:Landroid/widget/ListView;

    const v0, 0x7f0903e9

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/i;->b:Landroid/view/View;

    const v0, 0x7f0903a0

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const v1, 0x7f080694

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0472

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    const v0, 0x7f080640

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 7

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/m/i;->a(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_2

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move-object v6, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/p/a;)V

    return-void

    :cond_1
    :goto_0
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/i;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method private a(Z)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/i;->b:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :catch_0
    move-exception p1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/i;->b:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private d()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/i;->d:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/i;->e:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/m/i;->d:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/m/i;->e:Ljava/lang/String;

    iget v2, p0, Lchat/ola/vn/m/i;->f:I

    invoke-direct {p0, v0, v1, v2}, Lchat/ola/vn/m/i;->a(Ljava/lang/String;Ljava/lang/String;I)V

    new-instance v0, Lchat/ola/vn/b/p;

    invoke-virtual {p0}, Lchat/ola/vn/m/i;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/b/p;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    iget-object v0, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/m/i;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/m/i;->f:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a_(I)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/m/i;->d:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/m/i;->e:Ljava/lang/String;

    iget v1, p0, Lchat/ola/vn/m/i;->f:I

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/m/i;->a(Ljava/lang/String;Ljava/lang/String;I)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p1, :cond_3

    :try_start_0
    iget v1, p0, Lchat/ola/vn/m/i;->f:I

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p0, Lchat/ola/vn/m/i;->g:Ljava/util/List;

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/i;->g:Ljava/util/List;

    if-nez v1, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v1, p0, Lchat/ola/vn/m/i;->g:Ljava/util/List;

    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const/4 v2, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/m/i;->g:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    iget-object v1, p0, Lchat/ola/vn/m/i;->g:Ljava/util/List;

    invoke-virtual {p1, v1}, Lchat/ola/vn/b/p;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/m/i;->c:Lchat/ola/vn/b/p;

    invoke-virtual {p1}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V

    iput p2, p0, Lchat/ola/vn/m/i;->f:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    :goto_2
    invoke-direct {p0, v0}, Lchat/ola/vn/m/i;->a(Z)V

    return-void
.end method

.method public c()I
    .locals 1

    const/16 v0, 0xd

    return v0
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0900c6

    if-eq v0, v1, :cond_1

    const v1, 0x7f09039f

    if-eq v0, v1, :cond_0

    const v1, 0x7f0905ca

    if-eq v0, v1, :cond_1

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/i;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/i;->c()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p0}, Lchat/ola/vn/m/i;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/i;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0
    .param p2    # Landroid/view/ViewGroup;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Landroid/os/Bundle;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    const p2, 0x7f0b004b

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/m/i;->a(Landroid/view/View;)V

    invoke-direct {p0}, Lchat/ola/vn/m/i;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p1
.end method
