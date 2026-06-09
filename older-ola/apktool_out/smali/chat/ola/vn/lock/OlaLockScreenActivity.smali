.class public Lchat/ola/vn/lock/OlaLockScreenActivity;
.super Landroid/app/Activity;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/lock/OlaLockScreenActivity$a;
    }
.end annotation


# static fields
.field protected static a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

.field public static r:J

.field private static w:Lchat/ola/vn/entity/r;


# instance fields
.field protected b:Landroid/view/animation/Animation;

.field protected c:Landroid/view/View;

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

.field private s:Landroid/view/View;

.field private t:Ljava/lang/String;

.field private u:Z

.field private v:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->v:I

    return-void
.end method

.method private a()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    const/4 v2, 0x0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->b()V

    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a(Landroid/content/Context;Lchat/ola/vn/lock/OlaLockScreenActivity$a;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/lock/OlaLockScreenActivity$a;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->v()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/entity/r;->a(Ljava/lang/String;)Lchat/ola/vn/entity/r;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    sget-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    iget-wide v0, v0, Lchat/ola/vn/entity/r;->c:J

    sput-wide v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    sget-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    iget-object v0, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    sput-object p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/lock/OlaLockScreenActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void

    :cond_1
    :goto_0
    const/4 p0, 0x0

    sput-boolean p0, Lchat/ola/vn/c;->c_:Z

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->reset()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->b()V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v0, 0x4

    if-lt p1, v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->b(Ljava/lang/String;)Z

    :cond_2
    return-void
.end method

.method private a(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->h:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->i:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->j:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->k:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->l:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->m:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->n:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->o:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->p:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->q:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->s:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setEnabled(Z)V

    return-void
.end method

.method private b()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

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

    iget-object v4, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->g:Landroid/widget/Button;

    goto :goto_1

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->g:Landroid/widget/Button;

    goto :goto_2

    :pswitch_1
    if-ge v2, v0, :cond_1

    iget-object v4, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->f:Landroid/widget/Button;

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->f:Landroid/widget/Button;

    goto :goto_2

    :pswitch_2
    if-ge v2, v0, :cond_2

    iget-object v4, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->e:Landroid/widget/Button;

    goto :goto_1

    :cond_2
    iget-object v3, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->e:Landroid/widget/Button;

    goto :goto_2

    :pswitch_3
    if-ge v2, v0, :cond_3

    iget-object v4, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->d:Landroid/widget/Button;

    :goto_1
    invoke-virtual {v4, v3}, Landroid/widget/Button;->setSelected(Z)V

    goto :goto_3

    :cond_3
    iget-object v3, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->d:Landroid/widget/Button;

    :goto_2
    invoke-virtual {v3, v1}, Landroid/widget/Button;->setSelected(Z)V

    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    iget v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->v:I

    const/16 v1, 0xa

    if-le v0, v1, :cond_5

    return-void

    :cond_5
    iget v0, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->v:I

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private b(Ljava/lang/String;)Z
    .locals 4

    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    iget-object v2, v2, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    sput-boolean v1, Lchat/ola/vn/c;->c_:Z

    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->finish()V

    sget-object p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/lock/OlaLockScreenActivity$a;->a()V

    :cond_0
    return v0

    :cond_1
    iget p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->v:I

    add-int/2addr p1, v0

    iput p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->v:I

    const-wide/16 v2, 0x3e8

    invoke-static {p0, v2, v3}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;J)V

    const-string p1, ""

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->t:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->b()V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->c:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    invoke-virtual {p1, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    invoke-virtual {p1, p0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    return v1

    :catch_0
    :try_start_1
    sput-boolean v1, Lchat/ola/vn/c;->c_:Z

    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->finish()V

    sget-object p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

    if-eqz p1, :cond_3

    sget-object p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->a:Lchat/ola/vn/lock/OlaLockScreenActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/lock/OlaLockScreenActivity$a;->a()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_3
    return v0
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    iget-boolean p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a(Z)V

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 0

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    iget-boolean p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->u:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a(Z)V

    return-void
.end method

.method public onBackPressed()V
    .locals 0

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
    invoke-direct {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a(Ljava/lang/String;)V

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
    invoke-direct {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a()V
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

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0158

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->setContentView(I)V

    const p1, 0x7f010042

    :try_start_0
    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x3e8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->b:Landroid/view/animation/Animation;

    :goto_0
    const p1, 0x7f0903b8

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->c:Landroid/view/View;

    const p1, 0x7f0903b4

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->d:Landroid/widget/Button;

    const p1, 0x7f0903b5

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->e:Landroid/widget/Button;

    const p1, 0x7f0903b6

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->f:Landroid/widget/Button;

    const p1, 0x7f0903b7

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->g:Landroid/widget/Button;

    const p1, 0x7f090387

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->h:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->h:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090388

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->i:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->i:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090389

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->j:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->j:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038a

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->k:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->k:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038b

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->l:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->l:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038c

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->m:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->m:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038d

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->n:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->n:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038e

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->o:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->o:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09038f

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->p:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->p:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090390

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->q:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->q:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0901de

    invoke-virtual {p0, p1}, Lchat/ola/vn/lock/OlaLockScreenActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->s:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/lock/OlaLockScreenActivity;->s:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method protected onResume()V
    .locals 1

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->a(Landroid/app/Activity;)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->w:Lchat/ola/vn/entity/r;

    iget-object v0, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/c;->c_:Z

    invoke-virtual {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
