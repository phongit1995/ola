.class public Lchat/ola/vn/m/b;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/d/a;


# instance fields
.field private a:Landroid/widget/TextView;

.field private b:Landroid/widget/TextView;

.field private c:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method private b(J)V
    .locals 4

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    const/4 v0, 0x0

    if-nez v2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    const p2, 0x7f0f02df

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_1

    :cond_0
    const-wide/16 v1, 0x2710

    cmp-long v3, p1, v1

    if-gtz v3, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    const p2, 0x7f0f02ad

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/b;->a:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    sget-wide v0, Lchat/ola/vn/h;->o:J

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " KEN"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/b;->b(J)V

    return-void
.end method

.method public b()I
    .locals 1

    const/16 v0, 0xa

    return v0
.end method

.method public onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onActivityCreated(Landroid/os/Bundle;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/b;->b()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return-void

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-string v0, "bank"

    const v1, 0x7f0f0435

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/b;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/m/m;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lcom/mg/ola/common/d/g;->a(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-string v0, "1900588883"

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;)V

    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f09011d -> :sswitch_4
        0x7f09012a -> :sswitch_3
        0x7f09012b -> :sswitch_2
        0x7f090140 -> :sswitch_1
        0x7f0902c4 -> :sswitch_1
        0x7f09039f -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b00c8

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p2, 0x7f090534

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/b;->a:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p2, 0x7f0902c4

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->b:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p2, 0x7f09011d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/4 p3, 0x0

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f0903a0

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    const p3, 0x7f080795

    invoke-virtual {p1, p3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f0903a3

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const p3, 0x7f0f00ea

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f09039f

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f090140

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f09012b

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    const p3, 0x7f09012a

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/b;->c:Landroid/view/View;

    return-object p1
.end method

.method public onResume()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    sget-wide v0, Lchat/ola/vn/h;->o:J

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/m/b;->b(J)V

    return-void
.end method
