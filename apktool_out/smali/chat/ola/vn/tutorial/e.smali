.class public Lchat/ola/vn/tutorial/e;
.super Lchat/ola/vn/tutorial/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Lchat/ola/vn/b/ac;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/tutorial/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/tutorial/e;->a:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    return-void
.end method

.method private v()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/e;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/tutorial/c;->b(Landroid/os/Bundle;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/b/ac;

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/e;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/ac;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ac;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/ac;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->a:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->x()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/e;->b:Lchat/ola/vn/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()Lchat/ola/vn/tutorial/c;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/tutorial/b;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0630

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public e()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/e;->v()V

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0556

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090031

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->x()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_1

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v0, v2

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a([Ljava/lang/String;[Ljava/lang/String;)V

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/tutorial/e;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b01ca

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090031

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0904a9

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/tutorial/e;->a:Landroid/widget/ListView;

    return-object p1
.end method
