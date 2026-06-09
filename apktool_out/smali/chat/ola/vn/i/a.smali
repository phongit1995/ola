.class public Lchat/ola/vn/i/a;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/widget/EditText;

.field private b:Landroid/widget/EditText;

.field private c:Lchat/ola/vn/entity/t;

.field private d:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/entity/t;)V
    .locals 3

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/i/a;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700db

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iput-object p2, p0, Lchat/ola/vn/i/a;->c:Lchat/ola/vn/entity/t;

    const v0, 0x7f0b002c

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/a;->setContentView(I)V

    const v0, 0x7f0904f6

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/a;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/i/a;->a:Landroid/widget/EditText;

    const v0, 0x7f0904f7

    invoke-virtual {p0, v0}, Lchat/ola/vn/i/a;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/i/a;->b:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/i/a;->a:Landroid/widget/EditText;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/i/a;->b:Landroid/widget/EditText;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    const p2, 0x7f0900ad

    invoke-virtual {p0, p2}, Lchat/ola/vn/i/a;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0900ae

    invoke-virtual {p0, p2}, Lchat/ola/vn/i/a;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f010042

    invoke-static {p1, p2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/a;->d:Landroid/view/animation/Animation;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :goto_0
    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/i/a;->dismiss()V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/a;->a:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->length()I

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/a;->a:Landroid/widget/EditText;

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/i/a;->d:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/a;->b:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->length()I

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/i/a;->b:Landroid/widget/EditText;

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/i/a;->a:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/a;->b:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/a;->c:Lchat/ola/vn/entity/t;

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/t;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/i/a;->c:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->e(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->h()V

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->g()V

    goto :goto_0

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900ad
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
