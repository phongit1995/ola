.class public Lchat/ola/vn/note/OlaNoteComposerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/view/View$OnTouchListener;
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;
.implements Lchat/ola/vn/view/e$a;
.implements Lchat/ola/vn/view/g$e;
.implements Lchat/ola/vn/view/h$b;
.implements Lchat/ola/vn/view/i$e;
.implements Lchat/ola/vn/view/j$a;
.implements Lcom/mg/ola/common/widget/a/a;


# static fields
.field private static A:Ljava/lang/String;

.field private static B:Ljava/lang/String;

.field public static e:Lchat/ola/vn/note/a;


# instance fields
.field private C:I

.field private D:Z

.field private E:I

.field private f:I

.field private g:I

.field private h:Landroid/view/animation/Animation;

.field private i:Landroid/view/animation/Animation;

.field private j:Landroid/view/View;

.field private k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

.field private l:Lchat/ola/vn/view/OlaTypingSuggestedText;

.field private m:Landroid/widget/EditText;

.field private n:Landroid/widget/TextView;

.field private o:Landroid/widget/ImageButton;

.field private p:Landroid/widget/ImageButton;

.field private q:Landroid/widget/ImageButton;

.field private r:Landroid/widget/ImageButton;

.field private s:Landroid/widget/FrameLayout;

.field private t:Lchat/ola/vn/view/h;

.field private u:Lchat/ola/vn/view/i;

.field private v:Lchat/ola/vn/view/d;

.field private w:Lchat/ola/vn/view/g;

.field private x:Lchat/ola/vn/view/j;

.field private y:Lchat/ola/vn/view/d;

.field private z:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->f:I

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iput-boolean v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->D:Z

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->E:I

    return-void
.end method

.method private B()V
    .locals 3

    const v0, 0x7f090334

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->j:Landroid/view/View;

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090336

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->n:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->n:Landroid/widget/TextView;

    const v1, 0x7f0f05b1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f04cf

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f090378

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->m:Landroid/widget/EditText;

    const v0, 0x7f090335

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700ec

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    mul-int/lit8 v1, v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setPopupMaxHeight(I)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    sget-boolean v1, Lchat/ola/vn/c/x;->r:Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAllowedSuggestion(Z)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const v0, 0x7f09048c

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->setOnSoftKeyboardListener(Lcom/mg/ola/common/widget/a/a;)V

    const v0, 0x7f0905cd

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    sget v1, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0}, Landroid/view/View;->getPaddingLeft()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-virtual {v0}, Landroid/view/View;->getPaddingRight()I

    move-result v0

    sub-int/2addr v1, v0

    iput v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->E:I

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->D()V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->C()V

    return-void
.end method

.method private C()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->D:Z

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    iget-byte v1, v1, Lchat/ola/vn/note/a;->c:B

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    iget-object v1, v1, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    sput-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    :cond_0
    const-string v1, ""

    sget-object v2, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    :cond_1
    sget-object v2, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    sget-object v2, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_2
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method private D()V
    .locals 3

    const v0, 0x7f09014e

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    const v0, 0x7f0903fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f09015c

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->o:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->o:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090143

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->p:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->p:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->p:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    const v0, 0x7f0902c8

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->q:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->q:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090310

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->r:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->r:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090600

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    const v2, 0x7f0807a0

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090360

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private E()V
    .locals 4

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    const-string v1, "output"

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private F()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InlinedApi"
        }
    .end annotation

    invoke-static {}, Lcom/mg/ola/common/d/g;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "android.intent.extra.ALLOW_MULTIPLE"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const v1, 0x7f0f060c

    invoke-virtual {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_0
    return-void
.end method

.method private G()Lchat/ola/vn/note/a;
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->N()Lchat/ola/vn/note/a;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    return-object v0
.end method

.method private H()V
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->N()Lchat/ola/vn/note/a;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    iput-byte v1, v0, Lchat/ola/vn/note/a;->c:B

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    invoke-virtual {v0}, Lchat/ola/vn/note/a;->b()V

    const v0, 0x7f0f0304

    invoke-static {p0, v0}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    :cond_0
    iput-boolean v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->D:Z

    invoke-virtual {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private N()Lchat/ola/vn/note/a;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/note/a;

    invoke-direct {v1}, Lchat/ola/vn/note/a;-><init>()V

    sput-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    const/4 v2, 0x0

    iput-byte v2, v1, Lchat/ola/vn/note/a;->c:B

    sget-object v1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    iput-object v0, v1, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/note/a;->b:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;

    return-object v0
.end method

.method private O()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private P()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->o:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->p:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->q:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->r:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->r:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->q:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->p:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->o:Landroid/widget/ImageButton;

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    :pswitch_4
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->o:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    :pswitch_5
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_5
        :pswitch_5
    .end packed-switch
.end method

.method private Q()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->f:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->j:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getHeight()I

    move-result v0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    sub-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->f:I

    :cond_0
    new-instance v0, Lchat/ola/vn/note/OlaNoteComposerActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/note/OlaNoteComposerActivity$3;-><init>(Lchat/ola/vn/note/OlaNoteComposerActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private R()V
    .locals 1

    new-instance v0, Lchat/ola/vn/note/OlaNoteComposerActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/note/OlaNoteComposerActivity$4;-><init>(Lchat/ola/vn/note/OlaNoteComposerActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private S()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->x:I

    sput v0, Lchat/ola/vn/e;->c:I

    iget v0, v1, Landroid/graphics/Point;->y:I

    :goto_0
    sput v0, Lchat/ola/vn/e;->d:I

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v1

    sput v1, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method private T()Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    return v0

    :pswitch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast v1, Lchat/ola/vn/view/e;

    invoke-virtual {v1}, Lchat/ola/vn/view/e;->c()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast v1, Lchat/ola/vn/view/e;

    invoke-virtual {v1}, Lchat/ola/vn/view/e;->e()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return v2

    :catch_0
    :cond_0
    :pswitch_1
    :try_start_2
    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return v2

    :catch_1
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/note/OlaNoteComposerActivity;)Lchat/ola/vn/view/OlaTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 8

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-wide/16 v5, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lchat/ola/vn/note/OlaNoteComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;JZ)V

    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;JZ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;JZ)V"
        }
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    const/4 p4, 0x0

    if-eqz p3, :cond_0

    move-object p1, p4

    :cond_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_1

    move-object p2, p4

    :cond_1
    sput-object p1, Lchat/ola/vn/note/OlaNoteComposerActivity;->A:Ljava/lang/String;

    sput-object p2, Lchat/ola/vn/note/OlaNoteComposerActivity;->B:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/note/OlaNoteComposerActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010036

    const p2, 0x7f01003d

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/note/OlaNoteComposerActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->m:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/note/OlaNoteComposerActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->j:Landroid/view/View;

    return-object p0
.end method

.method private c(Z)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xc
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/note/OlaNoteComposerActivity$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity$1;-><init>(Lchat/ola/vn/note/OlaNoteComposerActivity;Z)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/note/OlaNoteComposerActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->f:I

    return p0
.end method

.method private d(Z)V
    .locals 4

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->P()V

    iget v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    iput-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    invoke-direct {p0, v3}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/view/j;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/j;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/j;->setOnVoiceRecordListener(Lchat/ola/vn/view/j$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    if-eq p1, v0, :cond_b

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->x:Lchat/ola/vn/view/j;

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_1

    :pswitch_1
    :try_start_2
    iput-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    invoke-direct {p0, v3}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    if-nez p1, :cond_2

    new-instance p1, Lchat/ola/vn/view/g;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/g;->setAllowVideo(Z)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    const v0, 0x7f0f040a

    invoke-virtual {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/g;->setSendButtonText(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/g;->setOlaPhotoListener(Lchat/ola/vn/view/g$e;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_2
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    if-eq p1, v0, :cond_b

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->w:Lchat/ola/vn/view/g;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :pswitch_2
    :try_start_4
    iput-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    invoke-direct {p0, v3}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    if-nez p1, :cond_4

    new-instance p1, Lchat/ola/vn/view/i;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/i;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/i;->setOnStickerClickedListener(Lchat/ola/vn/view/i$e;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_4
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    if-eq p1, v0, :cond_b

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->u:Lchat/ola/vn/view/i;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_0

    :pswitch_3
    :try_start_6
    invoke-direct {p0, v3}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    if-nez p1, :cond_6

    new-instance p1, Lchat/ola/vn/view/e;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/e;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast p1, Lchat/ola/vn/view/e;

    invoke-virtual {p1}, Lchat/ola/vn/view/e;->b()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast p1, Lchat/ola/vn/view/e;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/e;->setOlaCameraListener(Lchat/ola/vn/view/e$a;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :cond_6
    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    if-eq p1, v0, :cond_b

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    goto/16 :goto_0

    :pswitch_4
    :try_start_8
    iput-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    invoke-direct {p0, v3}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    if-nez p1, :cond_8

    new-instance p1, Lchat/ola/vn/view/h;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/h;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/h;->setOlaSmileyListener(Lchat/ola/vn/view/h$b;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    :cond_8
    :try_start_9
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    if-eq p1, v0, :cond_c

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->t:Lchat/ola/vn/view/h;

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1

    goto :goto_2

    :pswitch_5
    :try_start_a
    iput-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    invoke-direct {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    if-eqz p1, :cond_a

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->Q()V

    goto :goto_2

    :cond_a
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->R()V

    goto :goto_2

    :catch_0
    :cond_b
    :goto_1
    :pswitch_6
    const/4 v3, 0x0

    :catch_1
    :cond_c
    :goto_2
    if-eqz v3, :cond_d

    new-instance p1, Lchat/ola/vn/note/OlaNoteComposerActivity$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/note/OlaNoteComposerActivity$2;-><init>(Lchat/ola/vn/note/OlaNoteComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    :catch_2
    :cond_d
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_6
    .end packed-switch
.end method

.method private e(Z)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    iget v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v0, v1, :cond_0

    sget v0, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;

    invoke-virtual {p1}, Lchat/ola/vn/view/d;->a()V

    :cond_2
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->y:Lchat/ola/vn/view/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private m(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1, p1}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lchat/ola/vn/note/OlaNoteComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->append(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private n(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 3

    :try_start_0
    iget v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->E:I

    iget v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->E:I

    const/4 v2, 0x0

    invoke-static {p1, v2}, Lchat/ola/vn/util/i;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/OlaTextView$b;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-static {v2, v0, v1}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;II)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-static {v2, v0, v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;II)Ljava/lang/CharSequence;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    return-object p1
.end method

.method private o(Ljava/lang/String;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    const-string v0, "UTF-8"

    invoke-static {p1, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionEnd()I

    move-result v2

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "file://"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-interface {v2, v3, v1}, Landroid/text/Editable;->delete(II)Landroid/text/Editable;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v2, v1}, Landroid/text/Editable;->charAt(I)C

    move-result v1

    const/16 v3, 0xa

    if-eq v1, v3, :cond_0

    const-string v1, "\n"

    invoke-interface {v2, v0, v1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    move-exception v1

    :try_start_2
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-interface {v2, v0, p1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    add-int/2addr v0, p1

    const-string p1, "\n"

    invoke-interface {v2, v0, p1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->O()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    return-void

    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->O()V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    throw p1
.end method

.method private p(Ljava/lang/String;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionEnd()I

    move-result v2

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#\n"

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-interface {v2, v3, v1}, Landroid/text/Editable;->delete(II)Landroid/text/Editable;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v2, v1}, Landroid/text/Editable;->charAt(I)C

    move-result v1

    const/16 v3, 0xa

    if-eq v1, v3, :cond_0

    const-string v1, "\n"

    invoke-interface {v2, v0, v1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    move-exception v1

    :try_start_2
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    invoke-interface {v2, v0, p1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    add-int/2addr v0, p1

    const-string p1, "\n"

    invoke-interface {v2, v0, p1}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    goto :goto_2

    :catch_1
    move-exception p1

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->O()V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    return-void

    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->O()V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    throw p1
.end method


# virtual methods
.method public I()Z
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->E()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V

    const/4 v0, 0x1

    return v0
.end method

.method public J()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const/4 v1, -0x1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public K()Z
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v1, v2, :cond_0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->s:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    const/4 v0, 0x1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public L()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-lez v1, :cond_1

    add-int/lit8 v1, v1, -0x1

    :cond_1
    add-int/lit8 v0, v1, 0x1

    const-string v3, ""

    invoke-virtual {v2, v1, v0, v3}, Ljava/lang/StringBuilder;->replace(IILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public M()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->C:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/w;)V
    .locals 1

    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->j(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public a(ZI)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iput v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->S()V

    sget v1, Lchat/ola/vn/e;->d:I

    sget v2, Lchat/ola/vn/e;->e:I

    sub-int/2addr v1, v2

    sub-int/2addr v1, p2

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v2, v1, :cond_0

    sput v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    invoke-virtual {v1, v2}, Lchat/ola/vn/e;->c(I)V

    :cond_0
    iput p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->f:I

    goto :goto_0

    :cond_1
    sget p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-nez p2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const v1, 0x7f07012a

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    sput p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    :cond_2
    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V

    iget p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    if-nez p1, :cond_3

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->e(Z)V

    :cond_3
    return-void
.end method

.method public a_(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public b_(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->T()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->p(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->T()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->m(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->o(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " @"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->m(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->p(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    const/4 v0, 0x2

    const/4 v1, -0x1

    if-ne p1, v0, :cond_0

    if-ne p2, v1, :cond_2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_2

    new-instance p1, Ljava/io/File;

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide p2

    invoke-static {p2, p3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    const/4 p3, 0x1

    invoke-static {p2, p1, p3}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;Ljava/io/File;Z)V

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->delete()Z

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->a_(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    if-ne p2, v1, :cond_2

    const-string p1, "all_path"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringArrayExtra(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    array-length p2, p1

    if-lez p2, :cond_2

    new-instance p2, Ljava/util/ArrayList;

    array-length p3, p1

    invoke-direct {p2, p3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 p3, 0x0

    :goto_0
    array-length v0, p1

    if-ge p3, v0, :cond_1

    aget-object v0, p1, p3

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p2}, Lchat/ola/vn/note/OlaNoteComposerActivity;->f(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :goto_1
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->z:Ljava/io/File;

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->T()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x0

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-static {p0, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Landroid/content/Context;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V

    return-void

    :sswitch_1
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->H()V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->onBackPressed()V

    return-void

    :sswitch_3
    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    const/4 p1, 0x4

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_1

    :goto_0
    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V

    return-void

    :sswitch_4
    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    const/4 p1, 0x3

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :sswitch_5
    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    const/4 p1, 0x1

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :sswitch_6
    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    const/4 p1, 0x2

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :sswitch_7
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090143 -> :sswitch_6
        0x7f09015c -> :sswitch_5
        0x7f0902b6 -> :sswitch_7
        0x7f0902c8 -> :sswitch_4
        0x7f090310 -> :sswitch_3
        0x7f090360 -> :sswitch_7
        0x7f09039c -> :sswitch_2
        0x7f09039e -> :sswitch_1
        0x7f0903e1 -> :sswitch_7
        0x7f09049c -> :sswitch_7
        0x7f090600 -> :sswitch_0
    .end sparse-switch
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    iget v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->C:I

    iget v1, p1, Landroid/content/res/Configuration;->orientation:I

    if-eq v0, v1, :cond_2

    iget p1, p1, Landroid/content/res/Configuration;->orientation:I

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->C:I

    :try_start_0
    iget p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    :try_start_1
    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast p1, Lchat/ola/vn/view/e;

    invoke-virtual {p1}, Lchat/ola/vn/view/e;->c()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->v:Lchat/ola/vn/view/d;

    check-cast p1, Lchat/ola/vn/view/e;

    invoke-virtual {p1}, Lchat/ola/vn/view/e;->e()V

    :cond_1
    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b015e

    invoke-virtual {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->setContentView(I)V

    const p1, 0x7f010021

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->h:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->h:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    const p1, 0x7f010024

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->i:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->i:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->B()V

    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090143

    const/4 v1, 0x1

    if-eq p1, v0, :cond_1

    const v0, 0x7f090310

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->F()V

    return v1

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->D:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->G()Lchat/ola/vn/note/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->f()S

    move-result v0

    sput-short v0, Lchat/ola/vn/c/x;->j:S
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 1

    const/4 p2, 0x5

    if-le p4, p2, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result p2

    if-ltz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result p2

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    iget-object p3, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    add-int/2addr p2, p4

    :try_start_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p3

    if-le p2, p3, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->l:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_2
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090336

    if-eq p1, v0, :cond_2

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    if-nez p1, :cond_1

    :goto_0
    invoke-direct {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    return v1

    :cond_1
    iput v1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    invoke-direct {p0, v1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V

    return v1

    :cond_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-eqz p1, :cond_3

    iget p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity;->g:I

    if-nez p1, :cond_1

    goto :goto_0

    :cond_3
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->c(Z)V

    :cond_4
    return v1
.end method
