.class public Lchat/ola/vn/i/m;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/m$a;
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

.field private h:Lchat/ola/vn/i/m$a;

.field private k:Landroid/widget/AdapterView$OnItemClickListener;

.field private l:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const/4 p1, -0x1

    iput p1, p0, Lchat/ola/vn/i/m;->l:I

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->requestWindowFeature(I)Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->setCanceledOnTouchOutside(Z)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/i/m;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v1, 0x3f333333    # 0.7f

    invoke-virtual {v0, v1}, Landroid/view/Window;->setDimAmount(F)V

    :cond_0
    const v0, 0x7f0b00cd

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/m;->setContentView(I)V

    const v0, 0x7f09031f

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setFadingEdgeLength(I)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setCacheColorHint(I)V

    new-instance v0, Lchat/ola/vn/i/m$1;

    invoke-virtual {p0}, Lchat/ola/vn/i/m;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lchat/ola/vn/i/m$1;-><init>(Lchat/ola/vn/i/m;Landroid/content/Context;Ljava/util/List;)V

    iput-object v0, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    sget v2, Lchat/ola/vn/f;->w:I

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->a:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->setDividerHeight(I)V

    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/m;->b:Landroid/widget/TextView;

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/m;->c:Landroid/widget/Button;

    const p1, 0x7f0900ae

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/m;->d:Landroid/widget/Button;

    const p1, 0x7f090302

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    const p1, 0x7f0902e6

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/m;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/m;->e:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/i/m;->c:Landroid/widget/Button;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->d:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->e:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->c:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->d:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/i/m;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/i/m;->l:I

    return p0
.end method


# virtual methods
.method public a(I)V
    .locals 0

    :try_start_0
    iput p1, p0, Lchat/ola/vn/i/m;->l:I

    iget-object p1, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    invoke-virtual {p1}, Lchat/ola/vn/i/m$a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Landroid/widget/AdapterView$OnItemClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/m;->k:Landroid/widget/AdapterView$OnItemClickListener;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/m$a;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    invoke-virtual {p1}, Lchat/ola/vn/i/m$a;->notifyDataSetChanged()V

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
    iget-object p1, p0, Lchat/ola/vn/i/m;->g:Landroid/content/DialogInterface$OnClickListener;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/m;->g:Landroid/content/DialogInterface$OnClickListener;

    const/4 v0, 0x1

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/m;->g:Landroid/content/DialogInterface$OnClickListener;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/m;->g:Landroid/content/DialogInterface$OnClickListener;

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
    .locals 7
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
    invoke-virtual {p0}, Lchat/ola/vn/i/m;->dismiss()V

    iget-object v0, p0, Lchat/ola/vn/i/m;->k:Landroid/widget/AdapterView$OnItemClickListener;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/i/m;->k:Landroid/widget/AdapterView$OnItemClickListener;

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-wide v5, p4

    invoke-interface/range {v1 .. v6}, Landroid/widget/AdapterView$OnItemClickListener;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public setTitle(Ljava/lang/CharSequence;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/i/m;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/m;->f:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public show()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/m;->h:Lchat/ola/vn/i/m$a;

    invoke-virtual {v0}, Lchat/ola/vn/i/m$a;->notifyDataSetChanged()V

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/i/n;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
