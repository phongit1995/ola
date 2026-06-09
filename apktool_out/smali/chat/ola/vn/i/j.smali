.class public Lchat/ola/vn/i/j;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/j$a;
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/i/j$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;ZLchat/ola/vn/i/j$a;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const v0, 0x7f0b00d4

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/j;->setContentView(I)V

    const v0, 0x7f090547

    if-eqz p2, :cond_0

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/i/j;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    const v0, 0x7f0f02a9

    :goto_0
    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(I)V

    goto :goto_1

    :cond_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/i/j;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f0f02aa

    goto :goto_0

    :catch_0
    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/i/j;->getWindow()Landroid/view/Window;

    move-result-object p2

    invoke-virtual {p2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object p2

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f0700db

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p2, Landroid/view/WindowManager$LayoutParams;->width:I

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900ae

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iput-object p3, p0, Lchat/ola/vn/i/j;->a:Lchat/ola/vn/i/j$a;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :cond_0
    :goto_0
    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/i/j;->dismiss()V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/j;->a:Lchat/ola/vn/i/j$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/j;->a:Lchat/ola/vn/i/j$a;

    invoke-interface {p1}, Lchat/ola/vn/i/j$a;->a()V

    goto :goto_0

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900ad
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
