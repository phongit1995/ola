.class public Lchat/ola/vn/tutorial/b;
.super Lchat/ola/vn/tutorial/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Lchat/ola/vn/b/y;

.field private c:Landroid/widget/Button;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/c;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/tutorial/b;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->y()V

    return-void
.end method

.method private v()V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/n/b;->c(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    const v1, 0x7f0f04f2

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    const v1, 0x7f0f04d8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private x()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->d()[Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->finish()V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/m/l;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-wide/16 v1, 0x7530

    new-instance v3, Lchat/ola/vn/tutorial/b$1;

    invoke-direct {v3, p0}, Lchat/ola/vn/tutorial/b$1;-><init>(Lchat/ola/vn/tutorial/b;)V

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    return-void
.end method

.method private y()V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    new-instance v0, Lchat/ola/vn/tutorial/b$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/tutorial/b$2;-><init>(Lchat/ola/vn/tutorial/b;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_0

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(S)V

    :cond_0
    return-void
.end method


# virtual methods
.method public c()Lchat/ola/vn/tutorial/c;
    .locals 1

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
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f00f7

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
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v1, "#ola"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v1, "#apk"

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v1, "#hai"

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090203

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->x()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->y()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b01c8

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09042c

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/tutorial/b;->a:Landroid/widget/ListView;

    iget-object p2, p0, Lchat/ola/vn/tutorial/b;->a:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance p2, Lchat/ola/vn/b/y;

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-direct {p2, p3}, Lchat/ola/vn/b/y;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/tutorial/b;->b:Lchat/ola/vn/b/y;

    iget-object p2, p0, Lchat/ola/vn/tutorial/b;->a:Landroid/widget/ListView;

    iget-object p3, p0, Lchat/ola/vn/tutorial/b;->b:Lchat/ola/vn/b/y;

    invoke-virtual {p2, p3}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p2, p0, Lchat/ola/vn/tutorial/b;->b:Lchat/ola/vn/b/y;

    invoke-virtual {p2}, Lchat/ola/vn/b/y;->notifyDataSetChanged()V

    const p2, 0x7f090203

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/tutorial/b;->c:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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
    invoke-virtual {p0}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/n/b;->c(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->x()V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/tutorial/b;->y()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
