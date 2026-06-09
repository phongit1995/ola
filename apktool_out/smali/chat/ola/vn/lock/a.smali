.class public Lchat/ola/vn/lock/a;
.super Lchat/ola/vn/lock/d;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/animation/Animation$AnimationListener;


# instance fields
.field protected a:Landroid/view/animation/Animation;

.field protected b:Landroid/view/View;

.field protected c:Landroid/widget/Button;

.field protected d:Landroid/widget/Button;

.field protected e:Landroid/widget/Button;

.field protected f:Landroid/widget/Button;

.field protected g:Landroid/widget/Button;

.field protected h:Landroid/widget/Button;

.field protected i:Landroid/widget/Button;

.field protected j:Landroid/widget/Button;

.field protected k:Landroid/widget/Button;

.field protected l:Landroid/widget/Button;

.field protected m:Landroid/widget/Button;

.field protected n:Landroid/widget/Button;

.field protected o:Landroid/widget/Button;

.field protected p:Landroid/widget/Button;

.field protected q:Landroid/widget/Button;

.field protected r:Landroid/widget/TextView;

.field protected s:Ljava/lang/String;

.field protected t:I

.field protected u:Landroid/widget/TextView;

.field protected v:Landroid/widget/TextView;

.field private w:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/lock/d;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/lock/a;->w:Z

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/lock/a;->t:I

    return-void
.end method

.method private A()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    const/4 v2, 0x0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/a;->B()V

    :cond_0
    return-void
.end method

.method private B()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    const/4 v3, 0x4

    if-ge v2, v3, :cond_4

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    goto :goto_3

    :pswitch_0
    if-ge v2, v0, :cond_0

    iget-object v4, p0, Lchat/ola/vn/lock/a;->f:Landroid/widget/Button;

    goto :goto_1

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/lock/a;->f:Landroid/widget/Button;

    goto :goto_2

    :pswitch_1
    if-ge v2, v0, :cond_1

    iget-object v4, p0, Lchat/ola/vn/lock/a;->e:Landroid/widget/Button;

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/lock/a;->e:Landroid/widget/Button;

    goto :goto_2

    :pswitch_2
    if-ge v2, v0, :cond_2

    iget-object v4, p0, Lchat/ola/vn/lock/a;->d:Landroid/widget/Button;

    goto :goto_1

    :cond_2
    iget-object v3, p0, Lchat/ola/vn/lock/a;->d:Landroid/widget/Button;

    goto :goto_2

    :pswitch_3
    if-ge v2, v0, :cond_3

    iget-object v4, p0, Lchat/ola/vn/lock/a;->c:Landroid/widget/Button;

    :goto_1
    invoke-virtual {v4, v3}, Landroid/widget/Button;->setSelected(Z)V

    goto :goto_3

    :cond_3
    iget-object v3, p0, Lchat/ola/vn/lock/a;->c:Landroid/widget/Button;

    :goto_2
    invoke-virtual {v3, v1}, Landroid/widget/Button;->setSelected(Z)V

    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    iget v0, p0, Lchat/ola/vn/lock/a;->t:I

    const/16 v1, 0xa

    if-le v0, v1, :cond_5

    return-void

    :cond_5
    iget v0, p0, Lchat/ola/vn/lock/a;->t:I

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/lock/a;->g:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->h:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->i:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->j:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->k:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->l:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->m:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->n:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->o:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->p:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->q:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    return-void
.end method

.method private f(Ljava/lang/String;)V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/lock/a;->w:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->reset()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/a;->B()V

    iget-object p1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v0, 0x4

    if-lt p1, v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/a;->e(Ljava/lang/String;)Z

    :cond_2
    return-void
.end method

.method private z()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/lock/a;->v:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget v0, p0, Lchat/ola/vn/lock/a;->t:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/lock/a;->v:Landroid/widget/TextView;

    const v3, 0x7f0f0596

    new-array v2, v2, [Ljava/lang/Object;

    iget v4, p0, Lchat/ola/vn/lock/a;->t:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v1

    :goto_0
    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/lock/a;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/lock/a;->v:Landroid/widget/TextView;

    const v3, 0x7f0f0597

    new-array v2, v2, [Ljava/lang/Object;

    iget v4, p0, Lchat/ola/vn/lock/a;->t:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v1

    goto :goto_0

    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/lock/d;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f044d

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

.method public d()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->finish()V

    return-void
.end method

.method protected e(Ljava/lang/String;)Z
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    sget-object v1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    iget-object v1, v1, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->v()V

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return v0

    :cond_0
    iget p1, p0, Lchat/ola/vn/lock/a;->t:I

    add-int/2addr p1, v0

    iput p1, p0, Lchat/ola/vn/lock/a;->t:I

    invoke-direct {p0}, Lchat/ola/vn/lock/a;->z()V

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->x()V

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    const-wide/16 v1, 0x3e8

    invoke-static {p1, v1, v2}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;J)V

    const-string p1, ""

    iput-object p1, p0, Lchat/ola/vn/lock/a;->s:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/a;->B()V

    iget-object p1, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/lock/a;->b:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    invoke-virtual {p1, p0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    const/4 p1, 0x0

    return p1

    :catch_0
    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f04e3

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Lchat/ola/vn/lock/d;
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/lock/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/lock/e;

    return-object v0
.end method

.method public j()Lchat/ola/vn/lock/d;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/lock/a;->w:Z

    iget-boolean p1, p0, Lchat/ola/vn/lock/a;->w:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/lock/a;->a(Z)V

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 0

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/lock/a;->w:Z

    iget-boolean p1, p0, Lchat/ola/vn/lock/a;->w:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/lock/a;->a(Z)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0901de

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    const-string p1, "9"

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/lock/a;->f(Ljava/lang/String;)V

    return-void

    :pswitch_1
    const-string p1, "8"

    goto :goto_0

    :pswitch_2
    const-string p1, "7"

    goto :goto_0

    :pswitch_3
    const-string p1, "6"

    goto :goto_0

    :pswitch_4
    const-string p1, "5"

    goto :goto_0

    :pswitch_5
    const-string p1, "4"

    goto :goto_0

    :pswitch_6
    const-string p1, "3"

    goto :goto_0

    :pswitch_7
    const-string p1, "2"

    goto :goto_0

    :pswitch_8
    const-string p1, "1"

    goto :goto_0

    :pswitch_9
    const-string p1, "0"

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/lock/a;->A()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x7f090387
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const/4 p2, 0x0

    const p3, 0x7f0b0148

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    const v0, 0x7f010042

    invoke-static {p3, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    iget-object p3, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x3e8

    invoke-virtual {p3, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iput-object p2, p0, Lchat/ola/vn/lock/a;->a:Landroid/view/animation/Animation;

    :goto_0
    const p2, 0x7f0903b8

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/lock/a;->b:Landroid/view/View;

    const p2, 0x7f0903bb

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->u:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->u:Landroid/widget/TextView;

    sget p3, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setTextColor(I)V

    const p2, 0x7f0903b4

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->c:Landroid/widget/Button;

    const p2, 0x7f0903b5

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->d:Landroid/widget/Button;

    const p2, 0x7f0903b6

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->e:Landroid/widget/Button;

    const p2, 0x7f0903b7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->f:Landroid/widget/Button;

    const p2, 0x7f090387

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->g:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->g:Landroid/widget/Button;

    const p3, 0x7f080136

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->g:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->g:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090388

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->h:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->h:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->h:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->h:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090389

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->i:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->i:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->i:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->i:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->j:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->j:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->j:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->j:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->k:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->k:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->k:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->k:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->l:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->l:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->l:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->l:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->m:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->m:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->m:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->m:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->n:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->n:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->n:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->n:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09038f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->o:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->o:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->o:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->o:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090390

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->p:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->p:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->p:Landroid/widget/Button;

    sget v0, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->p:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0901de

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->q:Landroid/widget/Button;

    iget-object p2, p0, Lchat/ola/vn/lock/a;->q:Landroid/widget/Button;

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->q:Landroid/widget/Button;

    sget p3, Lchat/ola/vn/f;->y:I

    invoke-virtual {p2, p3}, Landroid/widget/Button;->setTextColor(I)V

    iget-object p2, p0, Lchat/ola/vn/lock/a;->q:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903ba

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->r:Landroid/widget/TextView;

    const p2, 0x7f0903b9

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/a;->v:Landroid/widget/TextView;

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/lock/a;->getArguments()Landroid/os/Bundle;

    move-result-object p2

    if-eqz p2, :cond_0

    const-string p3, "passCodeIndicatorTextView"

    const/4 v0, 0x0

    invoke-virtual {p2, p3, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/lock/a;->r:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_0
    return-object p1
.end method

.method protected v()V
    .locals 0

    return-void
.end method

.method protected x()V
    .locals 0

    return-void
.end method
