.class public Lchat/ola/vn/tradingvip/c;
.super Lchat/ola/vn/tradingvip/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/view/animation/Animation;

.field private b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private c:Landroid/widget/EditText;

.field private d:Landroid/widget/EditText;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/tradingvip/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/tradingvip/c;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/tradingvip/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/c;->x()V

    return-void
.end method

.method private v()V
    .locals 3

    sget-object v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/tradingvip/c;->f:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/c;->e:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method private x()V
    .locals 7

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/tradingvip/c;->y()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-wide/16 v0, 0x0

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v4, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, ","

    const-string v6, ""

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-wide v0, v4

    :catch_0
    :try_start_2
    iget-object v4, p0, Lchat/ola/vn/tradingvip/c;->d:Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move v2, v4

    :catch_1
    :try_start_3
    sput-wide v0, Lchat/ola/vn/tradingvip/d;->a:J

    sput v2, Lchat/ola/vn/tradingvip/d;->b:I

    invoke-static {v3}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->c(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/tradingvip/c$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/tradingvip/c$5;-><init>(Lchat/ola/vn/tradingvip/c;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/d;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void
.end method

.method private y()Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v2, p0, Lchat/ola/vn/tradingvip/c;->a:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->startAnimation(Landroid/view/animation/Animation;)V

    return v0

    :cond_0
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v2, p0, Lchat/ola/vn/tradingvip/c;->a:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :cond_1
    const/4 v0, 0x1

    :catch_0
    return v0
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/tradingvip/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/tradingvip/a;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/tradingvip/d;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tradingvip/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0655

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->isFocused()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    :goto_0
    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0901ee

    if-eq p1, v0, :cond_2

    const v0, 0x7f090373

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_2

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/tradingvip/c;->x()V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->C()Lchat/ola/vn/tradingvip/a;

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b0177

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090407

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance p2, Lchat/ola/vn/b/q;

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p3

    invoke-direct {p2, p3}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/b/q$a;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {p3, p2}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object p3, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance p3, Lchat/ola/vn/tradingvip/c$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/tradingvip/c$1;-><init>(Lchat/ola/vn/tradingvip/c;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const p2, 0x7f0905ed

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/EditText;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->d:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->d:Landroid/widget/EditText;

    const-string p3, "0"

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    const p2, 0x7f0902c3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/EditText;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/tradingvip/c$2;

    invoke-direct {p3, p0}, Lchat/ola/vn/tradingvip/c$2;-><init>(Lchat/ola/vn/tradingvip/c;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/tradingvip/c$3;

    invoke-direct {p3, p0}, Lchat/ola/vn/tradingvip/c$3;-><init>(Lchat/ola/vn/tradingvip/c;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->c:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/tradingvip/c$4;

    invoke-direct {p3, p0}, Lchat/ola/vn/tradingvip/c$4;-><init>(Lchat/ola/vn/tradingvip/c;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->h()Landroid/content/Intent;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->h()Landroid/content/Intent;

    move-result-object p2

    const-string p3, "_buddy_id"

    invoke-virtual {p2, p3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    iget-object p3, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setEnabled(Z)V

    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->d:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->requestFocus()Z

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/tradingvip/c;->b:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->requestFocus()Z

    :goto_0
    const p2, 0x7f0905f7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->e:Landroid/widget/TextView;

    const p2, 0x7f0905ef

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->f:Landroid/widget/ImageView;

    const p2, 0x7f090373

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0901ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/c;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p2

    const p3, 0x7f010042

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/tradingvip/c;->a:Landroid/view/animation/Animation;

    return-object p1
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/tradingvip/a;->onResume()V

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/c;->v()V

    return-void
.end method
