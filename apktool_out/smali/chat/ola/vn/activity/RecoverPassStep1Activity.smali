.class public Lchat/ola/vn/activity/RecoverPassStep1Activity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Landroid/view/animation/Animation;

.field private g:Landroid/widget/RadioGroup;

.field private h:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 1

    const v0, 0x7f09000a

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->e:Landroid/widget/EditText;

    const v0, 0x7f090372

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900be

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->h:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900be

    if-eq p1, v0, :cond_1

    const v0, 0x7f090372

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    const p1, 0x7f0f0258

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->e:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->f:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0192

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->B()V

    const p1, 0x7f010042

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->f:Landroid/view/animation/Animation;

    const p1, 0x7f0903e2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/RecoverPassStep1Activity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RadioGroup;

    iput-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->g:Landroid/widget/RadioGroup;

    iget-object p1, p0, Lchat/ola/vn/activity/RecoverPassStep1Activity;->g:Landroid/widget/RadioGroup;

    new-instance v0, Lchat/ola/vn/activity/RecoverPassStep1Activity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/RecoverPassStep1Activity$1;-><init>(Lchat/ola/vn/activity/RecoverPassStep1Activity;)V

    invoke-virtual {p1, v0}, Landroid/widget/RadioGroup;->setOnCheckedChangeListener(Landroid/widget/RadioGroup$OnCheckedChangeListener;)V

    return-void
.end method
