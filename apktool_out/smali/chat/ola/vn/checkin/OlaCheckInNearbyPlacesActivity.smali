.class public Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/p/a;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Landroid/view/View;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Landroid/view/View;

.field private k:Z

.field private l:Landroid/view/View;

.field private m:Lchat/ola/vn/b/p;

.field private n:I

.field private o:Ljava/util/List;
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
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->k:Z

    return-void
.end method

.method private C()V
    .locals 1

    const v0, 0x7f0b004b

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->setContentView(I)V

    const v0, 0x7f090319

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f0903e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->f:Landroid/view/View;

    const v0, 0x7f090263

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->j:Landroid/view/View;

    const v0, 0x7f09027c

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->l:Landroid/view/View;

    const v0, 0x7f0900be

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private D()V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "longitude"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->g:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "latitude"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->h:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "venueId"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->i:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->g:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->h:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-direct {p0, v0, v1, v2}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->a(Ljava/lang/String;Ljava/lang/String;I)V

    new-instance v0, Lchat/ola/vn/b/p;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/p;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/p;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

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

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->c(Z)V

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

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->c(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method private c(Z)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->f:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :catch_0
    move-exception p1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->f:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->n:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method protected a()V
    .locals 0

    return-void
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

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->g:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->h:Ljava/lang/String;

    iget v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->n:I

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->a(Ljava/lang/String;Ljava/lang/String;I)V

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

    if-eqz p1, :cond_6

    :try_start_0
    iget v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->n:I

    if-nez v1, :cond_2

    const/4 v1, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->i:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {p1, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->o:Ljava/util/List;

    goto :goto_4

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->o:Ljava/util/List;

    if-nez v1, :cond_3

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->o:Ljava/util/List;

    :cond_3
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const/4 v2, 0x0

    :goto_2
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->i:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    add-int/lit8 v2, v2, -0x1

    invoke-interface {v1, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_3

    :cond_4
    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->o:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    :goto_4
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->o:Ljava/util/List;

    invoke-virtual {p1, v1}, Lchat/ola/vn/b/p;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->m:Lchat/ola/vn/b/p;

    invoke-virtual {p1}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V

    iput p2, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->n:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_6
    :goto_5
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->c(Z)V

    return-void
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

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->finish()V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0900be -> :sswitch_0
        0x7f0900c6 -> :sswitch_1
        0x7f090263 -> :sswitch_0
        0x7f09027c -> :sswitch_0
        0x7f0905ca -> :sswitch_1
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->C()V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->D()V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "showBackButton"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->k:Z

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->j:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-boolean p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->k:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->j:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->j:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->l:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInNearbyPlacesActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
