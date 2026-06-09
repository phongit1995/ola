.class public Lchat/ola/vn/i/q;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/q$a;
    }
.end annotation


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;

.field private e:Landroid/view/View;

.field private f:Landroid/view/View;

.field private g:Landroid/content/DialogInterface$OnClickListener;

.field private h:Lchat/ola/vn/i/q$a;

.field private k:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/i/q;->k:I

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->requestWindowFeature(I)Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->setCanceledOnTouchOutside(Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/i/q;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v1, 0x3f333333    # 0.7f

    invoke-virtual {v0, v1}, Landroid/view/Window;->setDimAmount(F)V

    :cond_0
    const v0, 0x7f0b00cd

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/q;->setContentView(I)V

    const v0, 0x7f09031f

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setFadingEdgeLength(I)V

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setCacheColorHint(I)V

    new-instance v0, Lchat/ola/vn/i/q$1;

    invoke-virtual {p0}, Lchat/ola/vn/i/q;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lchat/ola/vn/i/q$1;-><init>(Lchat/ola/vn/i/q;Landroid/content/Context;Ljava/util/List;)V

    iput-object v0, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    sget v2, Lchat/ola/vn/f;->w:I

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/i/q;->a:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->setDividerHeight(I)V

    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/q;->b:Landroid/widget/TextView;

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/q;->c:Landroid/widget/Button;

    const p1, 0x7f0900ae

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/q;->d:Landroid/widget/Button;

    const p1, 0x7f090302

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/q;->f:Landroid/view/View;

    const p1, 0x7f0902e6

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/q;->e:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/i/q;->c:Landroid/widget/Button;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->d:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->e:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->f:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->c:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->d:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/q;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/q;->k:I

    return p0
.end method

.method public static a(Landroid/content/Context;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/i/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/q;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/q;->a(Ljava/util/List;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/q;->show()V

    :cond_1
    return-void
.end method


# virtual methods
.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/q$a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    invoke-virtual {p1}, Lchat/ola/vn/i/q$a;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/i/q;->g:Landroid/content/DialogInterface$OnClickListener;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/q;->g:Landroid/content/DialogInterface$OnClickListener;

    const/4 v0, 0x1

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/q;->g:Landroid/content/DialogInterface$OnClickListener;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/q;->g:Landroid/content/DialogInterface$OnClickListener;

    const/4 v0, 0x0

    :goto_0
    invoke-interface {p1, p0, v0}, Landroid/content/DialogInterface$OnClickListener;->onClick(Landroid/content/DialogInterface;I)V

    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900ad
        :pswitch_1
        :pswitch_0
    .end packed-switch
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
    invoke-virtual {p0}, Lchat/ola/vn/i/q;->dismiss()V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/i/q;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public show()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/q;->h:Lchat/ola/vn/i/q$a;

    invoke-virtual {v0}, Lchat/ola/vn/i/q$a;->notifyDataSetChanged()V

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/i/n;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
