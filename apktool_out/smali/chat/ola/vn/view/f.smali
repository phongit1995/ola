.class public Lchat/ola/vn/view/f;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/f$a;
    }
.end annotation


# instance fields
.field private a:Landroid/view/View;

.field private b:Landroid/view/View;

.field private c:Landroid/view/View;

.field private d:Landroid/view/View;

.field private e:Lchat/ola/vn/view/f$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/f;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/f;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/f;->a(Landroid/content/Context;)V

    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 1

    const v0, 0x7f0b0133

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/f;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const p1, 0x7f090464

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/f;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/f;->a:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/f;->a:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0904da

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/f;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/f;->b:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/f;->b:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0904d8

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/f;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/f;->c:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/f;->c:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090467

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/f;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/f;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/f;->d:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public getOnMoreActionClickedListener()Lchat/ola/vn/view/f$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090464

    if-eq p1, v0, :cond_3

    const v0, 0x7f090467

    if-eq p1, v0, :cond_2

    const v0, 0x7f0904d8

    if-eq p1, v0, :cond_1

    const v0, 0x7f0904da

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    invoke-interface {p1}, Lchat/ola/vn/view/f$a;->O()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    invoke-interface {p1}, Lchat/ola/vn/view/f$a;->P()V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    invoke-interface {p1}, Lchat/ola/vn/view/f$a;->Q()V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    invoke-interface {p1}, Lchat/ola/vn/view/f$a;->N()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method public setOnMoreActionClickedListener(Lchat/ola/vn/view/f$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/f;->e:Lchat/ola/vn/view/f$a;

    return-void
.end method

.method public setSendVipDayButtonVisibility(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/f;->d:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public setTradingVipButtonVisibility(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/f;->c:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public setTransferKenButtonVisibility(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/f;->b:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
