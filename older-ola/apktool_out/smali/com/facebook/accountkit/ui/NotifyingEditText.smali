.class public final Lcom/facebook/accountkit/ui/NotifyingEditText;
.super Landroid/support/v7/widget/AppCompatEditText;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/NotifyingEditText$NotifyingInputConnection;,
        Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;
    }
.end annotation


# instance fields
.field private onSoftKeyListener:Landroid/view/View$OnKeyListener;

.field private pasteListener:Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/support/v7/widget/AppCompatEditText;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2}, Landroid/support/v7/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p2    # Landroid/util/AttributeSet;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2, p3}, Landroid/support/v7/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method static synthetic access$000(Lcom/facebook/accountkit/ui/NotifyingEditText;)Landroid/view/View$OnKeyListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/NotifyingEditText;->onSoftKeyListener:Landroid/view/View$OnKeyListener;

    return-object p0
.end method


# virtual methods
.method public onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    .locals 2

    new-instance v0, Lcom/facebook/accountkit/ui/NotifyingEditText$NotifyingInputConnection;

    invoke-super {p0, p1}, Landroid/support/v7/widget/AppCompatEditText;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;

    move-result-object p1

    const/4 v1, 0x1

    invoke-direct {v0, p0, p1, v1}, Lcom/facebook/accountkit/ui/NotifyingEditText$NotifyingInputConnection;-><init>(Lcom/facebook/accountkit/ui/NotifyingEditText;Landroid/view/inputmethod/InputConnection;Z)V

    return-object v0
.end method

.method public onTextContextMenuItem(I)Z
    .locals 2

    invoke-super {p0, p1}, Landroid/support/v7/widget/AppCompatEditText;->onTextContextMenuItem(I)Z

    move-result v0

    const v1, 0x1020022

    if-eq p1, v1, :cond_0

    return v0

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/NotifyingEditText;->pasteListener:Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/NotifyingEditText;->pasteListener:Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;->onTextPaste()V

    :cond_1
    return v0
.end method

.method public setOnSoftKeyListener(Landroid/view/View$OnKeyListener;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/NotifyingEditText;->onSoftKeyListener:Landroid/view/View$OnKeyListener;

    return-void
.end method

.method public setPasteListener(Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/NotifyingEditText;->pasteListener:Lcom/facebook/accountkit/ui/NotifyingEditText$PasteListener;

    return-void
.end method
