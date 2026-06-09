.class public Lchat/ola/vn/i/r;
.super Lchat/ola/vn/i/p;


# instance fields
.field protected b:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/i/p;-><init>(Landroid/content/Context;)V

    const p1, 0x7f0900c8

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/r;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/r;->b:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/i/r;->b:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/util/List;)Lchat/ola/vn/i/r;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lchat/ola/vn/i/r;"
        }
    .end annotation

    if-eqz p1, :cond_1

    new-instance v0, Landroid/widget/ArrayAdapter;

    invoke-virtual {p0}, Lchat/ola/vn/i/r;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x1090003

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-direct {v0, v1, v2, p1}, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context;ILjava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/i/r;->a:Landroid/widget/EditText;

    check-cast p1, Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaSuggestEditText;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/i/r;->b:Landroid/view/View;

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/i/r;->b:Landroid/view/View;

    const/16 v0, 0x8

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-object p0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/i/p;->onClick(Landroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900c8

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/r;->a:Landroid/widget/EditText;

    check-cast p1, Lchat/ola/vn/view/OlaSuggestEditText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->a()V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/i/r;->getContext()Landroid/content/Context;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/r;->a:Landroid/widget/EditText;

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-void
.end method

.method public setContentView(I)V
    .locals 0

    const p1, 0x7f0b009c

    invoke-super {p0, p1}, Lchat/ola/vn/i/p;->setContentView(I)V

    return-void
.end method
