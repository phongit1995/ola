.class public Lchat/ola/vn/activity/MarriageRequestComposerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private e:Lchat/ola/vn/view/OlaTypingSuggestedText;

.field private f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private g:Landroid/widget/ImageView;

.field private h:S

.field private i:Landroid/widget/ScrollView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private D()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    const v0, 0x7f0f0324

    invoke-static {p0, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V

    return-void

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    const v0, 0x7f0f02b7

    invoke-static {p0, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V

    return-void

    :cond_1
    const/4 v2, 0x2

    sput-short v2, Lchat/ola/vn/c/x;->j:S

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    :try_start_0
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-short v5, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    const/4 v6, 0x0

    new-instance v3, Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity$3;-><init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v7

    move-object v3, v0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    const v2, 0x7f0f02b6

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "@"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v1

    invoke-static {p0, v2, v3}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->finish()V

    return-void
.end method

.method private E()Z
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const v2, 0x7f0f00a2

    const v3, 0x7f0f0093

    const v4, 0x7f0f06c2

    const v5, 0x7f0f0577

    new-instance v6, Lchat/ola/vn/activity/MarriageRequestComposerActivity$5;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity$5;-><init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "_buddy_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    const-class p1, Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-virtual {v0, p0, p1}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected B()V
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    iget-short v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    invoke-static {v1}, Lchat/ola/vn/util/c;->a(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void
.end method

.method public C()V
    .locals 3

    const v0, 0x7f0b00e4

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->setContentView(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const v0, 0x7f09009e

    :try_start_1
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09009f

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09010d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09010e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900a8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const v0, 0x7f09044b

    :try_start_2
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    iput-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->i:Landroid/widget/ScrollView;

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    const v0, 0x7f090286

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    const v0, 0x7f090517

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    sget-boolean v1, Lchat/ola/vn/c/x;->r:Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAllowedSuggestion(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090406

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    sget-boolean v1, Lchat/ola/vn/c/x;->r:Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAllowedSuggestion(Z)V

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/b/q$a;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v1, v0}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700ec

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    mul-int/lit8 v1, v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setPopupMaxHeight(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/16 v1, 0x13

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setGravity(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;-><init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "_buddy_id"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/util/h;->a(Landroid/text/Editable;)V

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->E()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090286

    const/4 v1, 0x0

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->D()V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p0, p1, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->finish()V

    return-void

    :cond_0
    iput-short v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    iget-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->g:Landroid/widget/ImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f09009e
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    sget v1, Lchat/ola/vn/f;->b:I

    invoke-direct {v0, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v0}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->C()V

    new-instance p1, Lchat/ola/vn/b/q;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0700ec

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    mul-int/lit8 v0, v0, 0x5

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setPopupMaxHeight(I)V

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    new-instance v0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity$1;-><init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    iget-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity$2;-><init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V

    const-wide/16 v1, 0x1f4

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    const/16 v0, 0x1b

    if-eq p1, v0, :cond_0

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_1

    const-string v0, "extra_edit_kul"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getShort(Ljava/lang/String;)S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    const-string v0, "extra_edit_content"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->B()V

    :cond_1
    invoke-super {p0, p1}, Lchat/ola/vn/c;->onRestoreInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_0

    const-string v0, "extra_edit_kul"

    iget-short v1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->h:S

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->e:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "extra_edit_content"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/c;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
